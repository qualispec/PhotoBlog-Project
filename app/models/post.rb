class Post < ActiveRecord::Base
  attr_accessible :url, :body, :user_id

  validates :url, :presence => true, :unless => :body
  validates :url, :format => { :with => /\.(jpg|png|bmp)$/ }, :if => :url
  validates :body, :presence => true, :unless => :url

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  default_scope order: 'posts.created_at DESC'
end
