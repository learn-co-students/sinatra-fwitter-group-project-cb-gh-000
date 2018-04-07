class User < ActiveRecord::Base
has_many :tweets
has_secure_password
validates :username, presence: true
validates :password, presence: true
validates :email, presence: true

  def slug
    username.downcase.gsub(' ','-')
  end

  def self.find_by_slug(slug)
    User.all.find{|x| x.slug == slug}
  end
end
