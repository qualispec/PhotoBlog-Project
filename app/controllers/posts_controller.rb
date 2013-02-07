class PostsController < ApplicationController
  before_filter :find_post_and_user, :correct_user, :only => [:update]

  def create
    @post = current_user.posts.create(params[:post])
    redirect_to user_path(current_user)
  end

  def show
    find_post_and_user
    @tag = Tag.new
  end

  def update
    @post.update_attributes(params[:post])
    redirect_to post_path(@post)
  end

  def destroy
    post = Post.find(params[:id])
    @user = post.user
    post.destroy
    redirect_to user_path(@user)
  end

  def index
    if params[:tag]
      @tag = Tag.find_by_name(params[:tag])
      @posts = Post.joins(:taggings).where('taggings.tag_id = ?', @tag.id)
    else
      @posts = params[:popularity] ? Post.order('posts.likes DESC') : Post.all
    end
  end

  def like
    post = Post.find(params[:id])
    post.likes += 1
    post.save
    redirect_to posts_path
  end

  def find_post_and_user
    @post = Post.find(params[:id])
    @user = @post.user
  end
end
