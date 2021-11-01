class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy, :have_been_read, :now_reading, :wants_to_read]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :have_been_read, :now_reading, :wants_to_read]
  before_action :set_book_form, only: [:show, :have_been_read, :now_reading, :wants_to_read]
  
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 6)
  end
  
  def show
    set_books("読んだ")
    counts(@user)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = 'ユーザ情報を更新しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ情報の更新に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = 'ユーザを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def have_been_read
    set_books("読んだ")
    counts(@user)
  end
  
  def now_reading
    set_books("今読んでいる")
    counts(@user)
  end

  def wants_to_read
    set_books("これから読みたい")
    counts(@user)
  end

  private
  
  def set_books(status)
    @pagy, @books = pagy(@user.books.where(status: status).order(id: :desc), items: 3)
  end
  
  def set_book_form
    @book = current_user.books.build
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
