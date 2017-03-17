class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :password, :email
  has_many :tweets

  def self.find_by_slug(slug)
    # origin_name = slug.split('-').collect.with_index do |word, i|
    #   if i != 0 && word.match(/\b(?:a|an|the|of|with|for)\b/)
    #     word
    #   else
    #     word.capitalize
    #   end
    # end
    origin_name = slug.gsub('-',' ')
    self.find_by(username: origin_name)
  end

  def slug
    self.username.downcase.gsub(' ', '-')
  end
end
