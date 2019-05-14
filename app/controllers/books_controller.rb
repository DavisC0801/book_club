class BooksController < ApplicationController
  def index
    @highest_rated_books = Book.highest_rated(3)
    @lowest_rated_books = Book.lowest_rated(3)
    @most_review_users = User.most_reviews(3)
    @total_review_count = Book.total_review_count
    @show_sort_button = true
    case params[:sort]
    when "rating-asc"
      @books = Book.sort_by_rating
    when "rating-desc"
      @books = Book.sort_by_rating(false)
    when "pages-asc"
      @books = Book.sort_by_page_count
    when "pages-desc"
      @books = Book.sort_by_page_count(false)
    when "reviews-asc"
      @books = Book.sort_by_review_count
    when "reviews-desc"
      @books = Book.sort_by_review_count(false)
    else
      @books = Book.all
    end
  end

  def show
    if Book.pluck(:id).include?(params[:id].to_i)
      @book = Book.find(params[:id])
    else
      flash[:notice] = "There is no book with that ID"
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
      author_names_input = book_params[:authors].split(",")

      author_names_input.each do |author_name|
        book.authors << Author.find_or_create_by(name: author_name.titlecase.strip)
      end

      flash[:notice] = "#{book.title} was added"
      redirect_to book_path(book)
    elsif !book.save && !Book.pluck.include?(book_params[:title])
      flash[:notice] = "This book has already been created."
      redirect_back(fallback_location: new_book_path)
    else
      flash[:notice] = "This new book could not be created."
      redirect_back(fallback_location: new_book_path)
    end
  end

  def destroy
    Book.destroy(params[:id].to_i)

    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :year_published, :page_count, :thumbnail, :authors)
  end
end
