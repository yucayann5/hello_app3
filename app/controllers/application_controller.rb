class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method %i(
    current_user
    logged_in?
  )

  def hello
    render html:"Hello,World"
  end

  private

  def require_login
    redirect_to login_path unless logged_in?
  end

  def logged_in?
    current_user.present?
  end

  def current_user
    @user ||= User.find_by(id: current_user_id)
  end

  def current_user_id
    session[:user_id]
  end
end
