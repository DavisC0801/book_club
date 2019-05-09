class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :username

  def reviews_count
    reviews.count
  end
end
