class TagsearchesController < ApplicationController
  def search
    @model = Book 
    @content = params[:content]
    @books = Book.where("category LIKE?","%#{@content}%")
    render "tagsearches/tagsearch"
  end
end
