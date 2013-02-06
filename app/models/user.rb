class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest

  validates :name, :email, :presence => true
  validates :email, :uniqueness => true

  has_many :posts
end
