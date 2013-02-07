class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find_by_cookie_token(cookies[:token])
  end

  def logged_in?
    !!current_user
  end

  def correct_user
    if current_user != @user
      flash[:errors] = "You must be logged in to view that page."
      redirect_to new_session_path
    end
  end
end
