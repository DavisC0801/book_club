require "rails_helper"

describe "As a Visitor" do
  describe "when I visit an author's show page" do
    before :each do
      @author_1 = Author.create!(name: "Homer")
      @book_1 = @author_1.books.create!(title: "The Illiad", page_count: 443, year_published: 850, thumbnail: "https://images.gr-assets.com/books/1388188509l/1371.jpg")
      @book_2 = @author_1.books.create(title: "The Oddessy", page_count: 250, year_published: 700, thumbnail: "https://nnp.wustl.edu/img/bookCovers/genericBookCover.jpg")
      user_1 = User.create!(username: "Chris Davis")
      user_2 = User.create!(username: "Alexandra Chakersa")
      @review_1 = @book_2.reviews.create!(title: "Terrible", rating: 1, text: "This was the worst book I've ever read.", user: user_1)
      @review_2 = @book_1.reviews.create!(title: "Great", rating: 5, text: "It's awesome!", user: user_1)
      @review_3 = @book_1.reviews.create!(title: "Not good", rating: 2, text: "I wouldn't recommend it.", user: user_2)
      travel 1.day
      @review_4 = @book_2.reviews.create!(title: "Terrible", rating: 1, text: "Absolutely bad.", user: user_2)
    end

    it "should show the highest rated review" do
      visit author_path(@author_1)

      within("#book-#{@book_1.id}") do
        expect(page).to have_content(@review_2.title)
        expect(page).to have_css("width:#{@review_2.rating_percentage};")
        expect(page).to have_link("Written by: #{@review_2.user.username}")
      end

      within("#book-#{@book_2.id}") do
        expect(page).to have_content(@review_4.title)
        expect(page).to have_css("width:#{@review_4.rating_percentage};")
        expect(page).to have_link(@review_4.user.username)
      end
    end

    it "should inform the user if the book has no reviews" do
      author_2 = Author.create!(name: "Harper Lee")
      book_3 = author_2.books.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")

      visit author_path(author_2)

      within("#book-#{book_3.id}") do
        expect(page).to have_content("This book has no reviews yet.")
      end
    end

    it "should inform the user if the author has no books" do
      author_2 = Author.create!(name: "Ernest Hemmingway")

      visit author_path(author_2)

      within("#book-list") do
        expect(page).to have_content("This author has no books in the database.")
      end
    end
  end
end
