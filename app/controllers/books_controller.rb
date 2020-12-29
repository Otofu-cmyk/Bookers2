class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = User.find(current_user.id)
    @books=Book.all
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user=User.find(current_user.id)
    @books=Book.all
    if @user.id == @book.user_id
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books=Book.all
  end

  def show
    # @user = User.find(params[:id])
    @new_book = Book.new
    @book = Book.find(params[:id])
    @book_user=User.find(@book.user_id)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
