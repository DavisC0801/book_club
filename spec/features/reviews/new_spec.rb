require "rails_helper"

RSpec.describe "as a visitor" do
  describe "when there is a book with the id matching the URI" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
    end

    it "loads the page" do
      visit new_book_review_path(@book_1)

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(new_book_review_path(@book_1))
    end
  end

  describe "when there is no book with the id matching the URI" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
    end

    it "redirects to the books index" do
      visit new_book_review_path(@book_1.id + 50)

      expect(current_path).to eq(books_path)
    end
  end
end
