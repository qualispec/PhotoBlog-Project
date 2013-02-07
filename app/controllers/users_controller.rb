class UsersController < ApplicationController
  before_filter :find_user, :only => [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    flash[:success] = "#{@user.name} created."
    redirect_to user_path(@user)
  end

  def show
    @post = Post.new
  end

  def find_user
    @user = User.find(params[:id])
  end
end