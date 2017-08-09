class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username
  validates_presence_of :email

  def slug
    self.username.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    self.where('username LIKE ?', "#{slug.gsub('-', ' ')}").take
  end
end