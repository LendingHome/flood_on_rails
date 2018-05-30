class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to '/' unless current_user
  end

end
