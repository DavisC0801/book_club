class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :username

  def self.sort_by_review_count(ascending = true)
    ascending ? first_or_last = 'FIRST' : first_or_last = 'LAST'
    ascending ? descending = '' : descending = ' DESC'
    order_arg = 'COUNT(reviews)' + descending + ' NULLS ' + first_or_last
    User.select('users.*, COUNT(reviews)')
        .left_joins(:reviews)
        .group('users.id')
        .order(order_arg)
  end

  def self.most_reviews(number)
    sort_by_review_count(false).limit(number)
  end

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
