class Book < ApplicationRecord
  has_many :book_authors
  has_many :reviews
  has_many :authors, through: :book_authors

  validates_presence_of :title
  validates_presence_of :page_count
  validates_presence_of :year_published

  def review_count
    reviews.count
  end

  def author_count
    authors.count
  end

  def coauthors(author)
    authors - [author]
  end
end
