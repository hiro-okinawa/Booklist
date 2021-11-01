class BooksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]


  def create
    set_user
    @book = current_user.books.build(book_params)
    
    if @book.save
      flash[:success] = '本を登録しました。'
      
      if @book.status == "読んだ本"
        redirect_to have_been_read_user_path(set_user)
      elsif @book.status == "今読んでいる本"
        redirect_to now_reading_user_path(set_user)
      else
        redirect_to wants_to_read_user_path(set_user)
      end
    
    else
      @pagy, @books = pagy(current_user.books.where(status: "読んだ本"), items: 3)
      flash[:danger] = '本の登録に失敗しました。'
      
      
      render '/users/have_been_read', user: @user
    end
  end

  def destroy
    @book.destroy
    flash[:success] = '本を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def book_params
    params.require(:book).permit(:book_name, :author_name, :status)
  end
  
  def correct_user
    @book = current_user.books.find_by(id: params[:id])
    unless @book
      redirect_to root_url
    end
  end

end
