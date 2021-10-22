class ApplicationController < ActionController::Base
  helper_method :current_user
  include SessionsHelper  #追記
  include Pagy::Backend
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  
end
