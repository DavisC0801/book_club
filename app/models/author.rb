class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors

  validates_presence_of :name

  def book_count
    books.count
  end

  def self.highest_rated(number)
    Author.joins(books: :reviews)
    .order("AVG(reviews.rating) DESC")
    .order(:name)
    .select("authors.*")
    .group("authors.id")
    .limit(number)
  end

  def rating_percentage
    (books.joins(:reviews).average("reviews.rating") / 5.0 * 100).round(0).to_i
  end
end
