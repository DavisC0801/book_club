class ReviewsController < ApplicationController
  def new
    if Book.pluck(:id).include?(params[:book_id].to_i)
      @book = Book.find(params[:book_id])
      @review = Review.new
    else
      flash[:notice] = "There is no book with that ID"
      redirect_to books_path
    end
  end

  def create
    user = User.find_or_create_by(username: params[:review][:user].titlecase)
    review = user.reviews.new(review_params)
    dupl_review = user.reviews.pluck(:book_id).include?(params[:book_id].to_i)
    if dupl_review || user.id.nil?
      flash[:notice] = "#{user.username} already submitted a review for this book" if dupl_review
      redirect_back(fallback_location: book_path(params[:book_id]))
    else
      if review.save
        redirect_to book_path(params[:book_id])
      else
        flash[:notice] = "Failed to add the review"
        redirect_back(fallback_location: book_path(params[:book_id]))
      end
    end
  end

  def destroy
    Review.destroy(params[:review_id])
    redirect_to user_path(params[:id])
  end

  private

  def review_params
    partial_params = params.require(:review).permit(:title, :rating, :text)
    partial_params[:book_id] = params[:book_id].to_i
    partial_params
  end
end
