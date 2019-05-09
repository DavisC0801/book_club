class ReviewsController < ApplicationController
  def new
    if Book.pluck(:id).include?(params[:book_id].to_i)
      @book = Book.find(params[:book_id])
    else
      redirect_to books_path
    end
  end
end