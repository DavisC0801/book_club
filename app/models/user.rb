class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :username

  def reviews_count
    reviews.count
  end

  def sorted_reviews(sort_order)
    case sort_order
    when "date-asc"
      reviews.order(updated_at: :asc)
    when "date-desc"
      reviews.order(updated_at: :desc)
    else
      reviews
    end
  end
end
