class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end

end
