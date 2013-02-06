class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    flash[:success] = "#{@user.name} created."
    redirect_to user_path(@user)
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new(user_id: @user.id)
  end
end