class Book < ApplicationRecord
  has_many :book_authors
  has_many :reviews
  has_many :authors, through: :book_authors

  validates_presence_of :title, :page_count, :year_published
  validates_uniqueness_of :title
  validates :year_published, numericality: { only_integer: true, greater_than_or_equal_to: -4000, less_than_or_equal_to: Time.now.year }
  validates :page_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def review_count
    reviews.count
  end

  def author_count
    authors.count
  end

  def average_rating
    calc = reviews.average(:rating)
    calc ? calc : 0
  end

  def coauthors(author)
    authors - [author]
  end
end
