class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    return unless session[:admin_id]
    session[:admin_id]
    @current_user ||= Admin.find_by_id(session[:admin_id])
  end
  
  helper_method :current_user
  
  def authenticate
    current_user.is_a?(Admin) ? true : access_denied
  end
  
  def access_denied
    redirect_to login_path and return false
  end
end
