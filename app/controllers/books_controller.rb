class BooksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:update,:destroy]

  def index
  end
  
  def create
    @book = current_user.books.build(book_params)
    set_user
    
    if @book.save
      flash[:success] = '本を登録しました。'
      
      if @book.status == "読んだ"
        redirect_to have_been_read_user_path(@user)
      elsif @book.status == "今読んでいる"
        redirect_to now_reading_user_path(@user)
      else
        redirect_to wants_to_read_user_path(@user)
      end
    
    else
      flash[:danger] = '本の登録に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end
  
  def update
    if @book.update(book_params)
      flash[:success] = '本の状態を更新しました。'
      
     redirect_back(fallback_location: root_path)
    else
        flash[:danger] = '本の状態の更新に失敗しました。'
        redirect_back(fallback_location: root_path)
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
