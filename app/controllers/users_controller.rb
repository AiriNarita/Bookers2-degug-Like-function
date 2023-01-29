class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]


  def show
    @user = User.find(params[:id])
   # @user = User.find(current_user.id)
    @books = @user.books
    @book = Book.new
    @btn = "Create Book"
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def index
    @users = User.all
    @book = Book.new
    @btn = "Create Book"
   #  @users = User.page(params[:page]).per(3).reverse_order

  end  

  def edit
    @user = User.find(params[:id])
    
    user_id = params[:id].to_i
    unless user_id == current_user.id
     redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      
      render :edit
    end
  end

  def follows
    user = User.find(params[:id])

    
    # @following_users = user.following_user.includes(:followed, :follower)
    @following_users = user.following_user
    # @follower_users = user.follower_user.includes(:followed, :follower)
    @follower_users = user.follower_user

  end

  def followers
    user = User.find(params[:id])
    @following_users = user.following_user
    @follower_users = user.follower_user
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

 
  
  before_action :ensure_correct_user, {only: [:edit, :update]}
end
