class UsersController < ApplicationController
  before_action :ensure_current_user_profile?, only: [:edit, :update]

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def ensure_current_user_profile?
      user = User.find(params[:id])
      if current_user.id !=  user.id
        redirect_to user_path(current_user)
      end
    end
end
