class ReviewsController < ApplicationController
  def new
    if Book.pluck(:id).include?(params[:book_id].to_i)
      @book = Book.find(params[:book_id])
      @review = Review.new
    else
      redirect_to books_path
    end
  end

  def create
    user = User.find_or_create_by!(username: params[:review][:user].titlecase)
    user.reviews.create(review_params)

    redirect_to book_path(params[:book_id])
  end

  private

  def review_params
    partial_params = params.require(:review).permit(:title, :rating, :text)
    partial_params[:book_id] = params[:book_id].to_i
    partial_params
  end
end