class BooksController < ApplicationController
  def index
    if user_signed_in?
      @book = Book.new
      @books = Book.all
    else
      redirect_to new_user_session_path
    end
  end

  def show
    if user_signed_in?
      @book = Book.find(params[:id])
      @user = User.find(@book.user_id)
    else
      redirect_to new_user_session_path
    end
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
      @books = Book.all
      render :index
    end
  end

  def edit
    if user_signed_in?
      @book = Book.find(params[:id])
    else
      redirect_to new_user_sessio_path
    end
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
end
