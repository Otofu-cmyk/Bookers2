class UsersController < ApplicationController
  def new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
    @users=User.all
    if @user.id == current_user.id
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    @book = Book.new

    @posts = Book.all
    books = @posts
    @books = current_user.books
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @users=User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new

    @posts = Book.all
    books = @posts
    user=User.find(params[:id])
    @books = user.books
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
