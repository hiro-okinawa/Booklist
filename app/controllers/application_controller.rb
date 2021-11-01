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
  
  def counts(user)
    @count_have_been_read = user.books.where(status: "読んだ").count
    @count_now_reading = user.books.where(status: "今読んでいる").count
    @count_wants_to_read = user.books.where(status: "これから読みたい").count
  end

end
