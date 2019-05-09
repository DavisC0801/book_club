class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    if Book.pluck(:id).include?(params[:id].to_i)
      @book = Book.find(params[:id])
    else
      redirect_to books_path
    end
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.create_with(
      year_published: book_params[:year_published],
      page_count: book_params[:page_count],
      thumbnail: book_params[:thumbnail]
    ).find_or_create_by(title: book_params[:title].titlecase)
    author = book.authors.find_or_create_by(name: book_params[:authors].titlecase)

    redirect_to book_path(book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :year_published, :page_count, :thumbnail, :authors)
  end
end
