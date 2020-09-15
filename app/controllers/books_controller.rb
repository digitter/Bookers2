class BooksController < ApplicationController
  before_action :ensure_current_user_book?, only: [:edit, :update]

  def index
    @book = Book.new
    @books = Book.includes(:user).all
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash[:notice] = 'Book was successfully created.'
      redirect_to book_path(book.id)
    else
      @user = User.find(current_user.id)
      @book = book
      @books = Book.all.includes(:user).all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def ensure_current_user_book?
      book = Book.find(params[:id])
      redirect_to books_path unless current_user.id == book.user_id
    end
end
