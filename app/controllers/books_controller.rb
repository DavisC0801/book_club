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
    book = Book.new(
      year_published: book_params[:year_published],
      page_count: book_params[:page_count],
      thumbnail: book_params[:thumbnail].presence || 'https://nnp.wustl.edu/img/bookCovers/genericBookCover.jpg',
      title: book_params[:title].titlecase)
    if book.save
      author_input = book_params[:authors].split(",")

      author_input.each do |author|
        book.authors << Author.find_or_create_by(name: author.titlecase.strip)
      end

      redirect_to book_path(book)
    else
      flash[:notice] = "This book has already been created"
      redirect_back(fallback_location: new_book_path)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :year_published, :page_count, :thumbnail, :authors)
  end
end
