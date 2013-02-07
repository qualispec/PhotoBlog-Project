class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user.authenticate(params[:user][:password])
      sign_in(@user)
      flash[:success] = "Welcome back!"
      redirect_to posts_path
    else
      flash[:errors] = "Invalid login credentials"
      render 'new'
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to new_session_path
  end

  def sign_in(user)
    cookies[:token] = user.set_cookie_token
  end

  def sign_out(user)
    cookies.delete(:token)
    user.clear_cookie_token
  end
end
