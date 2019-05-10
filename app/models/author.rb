class Author < ApplicationRecord
  has_many :book_authors
  has_many :books, through: :book_authors

  validates_presence_of :name

  def self.destroy_author(author_id)
    relevant_book_authors_ids = BookAuthor.where(author_id: author_id).pluck(:id)
    relevant_book_authors_ids.each do |book_author_id|
      book_id = BookAuthor.find(book_author_id).book_id
      BookAuthor.where("book_id" => book_id).destroy_all
      Review.where("book_id" => book_id).destroy_all
      Book.destroy(book_id)
    end
    Author.destroy(author_id)
  end

  def book_count
    books.count
  end
end
