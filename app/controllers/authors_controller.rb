class AuthorsController < ApplicationController
  def show
    if Author.pluck(:id).include?(params[:id].to_i)
      @author = Author.find(params[:id])
    else
      redirect_to books_path
    end
  end

  def index
  end

  def destroy
    relevant_book_authors_ids = BookAuthor.where(author_id: params[:id].to_i).pluck(:id)
    relevant_book_authors_ids.each do |book_author_id|
      book_id = BookAuthor.find(book_author_id).book_id
      BookAuthor.where("book_id" => book_id).destroy_all
      Review.where("book_id" => book_id).destroy_all
      Book.destroy(book_id)
    end
    Author.destroy(params[:id].to_i)

    redirect_to books_path
  end
end