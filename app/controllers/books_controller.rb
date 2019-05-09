class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    if Book.pluck(:id).include?(params[:id].to_i)
      @book = Book.find(params[:id])
    else
      flash[:notice] = "There is no book with that ID"
      redirect_to books_path
    end
  end
end