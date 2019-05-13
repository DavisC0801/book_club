class Book < ApplicationRecord
  has_many :book_authors, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :authors, through: :book_authors

  validates_presence_of :title, :page_count, :year_published
  validates_uniqueness_of :title
  validates :year_published, numericality: { only_integer: true, greater_than_or_equal_to: -4000, less_than_or_equal_to: Time.now.year }
  validates :page_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def self.sort_by_rating(ascending = true)
    ascending ? first_or_last = 'FIRST' : first_or_last = 'LAST'
    ascending ? descending = '' : descending = ' DESC'
    order_arg = 'AVG(reviews.rating)' + descending + ' NULLS ' + first_or_last
    Book.select('books.*, AVG(reviews.rating)')
        .left_joins(:reviews)
        .group('books.id')
        .order(order_arg)
  end

  def self.sort_by_page_count(ascending = true)
    if ascending
      Book.order(:page_count)
    else
      Book.order(page_count: :desc)
    end
  end

  def self.sort_by_review_count(ascending = true)
    ascending ? first_or_last = 'FIRST' : first_or_last = 'LAST'
    ascending ? descending = '' : descending = ' DESC'
    order_arg = 'COUNT(reviews)' + descending + ' NULLS ' + first_or_last
    Book.select('books.*, COUNT(reviews)')
        .left_joins(:reviews)
        .group('books.id')
        .order(order_arg)
  end

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
