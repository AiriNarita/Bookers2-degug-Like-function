class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end


  def destroy
   
  end
end
