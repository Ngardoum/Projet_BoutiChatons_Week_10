class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @tag = Tag.new
  end

  def add_tag
    @book = Book.find(params[:id])
    @tag = @book.tags.create(tag_params)

    respond_to do |format|
      format.html { redirect_to @book, notice: "Tag ajouté avec succès." }
      format.js   # Renvoie vers add_tag.js.erb
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end