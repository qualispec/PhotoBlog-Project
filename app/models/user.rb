class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  has_secure_password

  validates :name, :email, :presence => true
  validates :email, :uniqueness => true
  validates :password, :presence => true, :length => { :minimum => 6 },
    :confirmation => true, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  has_many :posts

  def self.find_by_cookie_token(token)
    user = where(cookie_token: token).first
    user.cookie_token ? user : false
  end

  def set_cookie_token
    update_attribute(:cookie_token, SecureRandom.base64) unless cookie_token
    cookie_token
  end

  def clear_cookie_token
    update_attribute(:cookie_token, nil)
  end
end
