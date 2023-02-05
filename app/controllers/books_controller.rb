class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @newBook = Book.new
    @user = @book.user
    @btn = "Create Book"
    @book_comment = BookComment.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user

  end

  def index
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorites).sort_by {|x| x.favorites.where(created_at: from...to).size}.reverse
    
    @book = Book.new
    #@books = Book.all
    @btn = "Create Book"
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    @btn = "Update Book"
    if @book.user == current_user
      render :edit
    else
       redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      @btn = "Update Book"
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end


