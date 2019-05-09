class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    if Book.pluck(:id).include?(params[:id].to_i)
      @book = Book.find(params[:id])
    else
      redirect_to "/books"
    end
  end

  def new
    @book = Book.new
  end
end
