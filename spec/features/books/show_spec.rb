require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when there is a book with the id matching the URI" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      @author_1 = @book_1.authors.create!(name: "Wilkie Collins")
      @author_2 = @book_1.authors.create!(name: "Charles Dickens")
      @author_3 = @book_2.authors.create!(name: "Harper Lee")
      user_1 = User.create(username: "Chris Davis")
      user_2 = User.create(username: "Alexandra Chakeres")
      @review_1 = @book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: user_1)
      @review_2 = @book_2.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: user_2)
      @review_3 = @book_1.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: user_2)
    end

    it "loads the page" do
      visit book_path(@book_1)

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(book_path(@book_1))
    end

    it "shows information for a particular book" do
      visit book_path(@book_1)

      expect(page).to have_content(@book_1.title)
      
      within "#book-show" do
        expect(page).to have_content(@author_1.name)
        expect(page).to have_content(@author_2.name)
        expect(page).to have_content("#{@book_1.page_count} pages")
        expect(page).to have_content("Published in #{@book_1.year_published}")
        expect(page).to have_css("img[src*='#{@book_1.thumbnail}']")

        expect(page).to_not have_content(@book_2.title)
      end

      within "#review-list" do
        expect(page).to have_content("Reviews")

        within "#review-#{@review_1.id}" do
          expect(page).to have_content(@review_1.title)
          expect(page).to have_content("Written by: #{@review_1.user.username}")
          expect(page).to have_content("Rating: #{@review_1.rating}/5")
          expect(page).to have_content(@review_1.text)
        end

        within "#review-#{@review_3.id}" do
          expect(page).to have_content(@review_3.title)
          expect(page).to have_content("Written by: #{@review_3.user.username}")
          expect(page).to have_content("Rating: #{@review_3.rating}/5")
          expect(page).to have_content(@review_3.text)
        end

        expect(page).to_not have_content(@review_2.title)
        expect(page).to_not have_content("This book has no reviews yet.")
        expect(page).to_not have_content("Author(s): unknown")

      end
    end

    describe "when I click a link to add a new review" do
      it "goes to the new review page for that book" do
        visit book_path(@book_1)

        click_link("Write a review")

        expect(current_path).to eq(new_book_review_path(@book_1))
      end
    end
  end

  describe "when there is no book with the id matching the URI" do
    it "redirects to the books index" do
      book_4 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")

      visit book_path(book_4.id + 50)

      expect(current_path).to eq(books_path)
      expect(page).to have_content("There is no book with that ID")
    end
  end

  describe "when the book has no reviews" do
    it "displays a message as such" do
      book_5 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")

      visit book_path(book_5)

      within "#review-list" do
        expect(page).to have_content("This book has no reviews yet.")
      end
    end
  end

  describe "when the book has no author" do
    it "says author is unknown" do
      book_6 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")

      visit book_path(book_6)

      within "#book-show" do
        expect(page).to have_content("Author(s): unknown")
      end
    end
  end

  describe "navigation bar" do
    before(:each) do
      @book_7 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
    end

    it "has a link to go to the homepage" do
      visit book_path(@book_7)

      within "nav" do
        click_link("Home")
      end

      expect(current_path).to eq(root_path)
    end

    it "has a link to go to the books index" do
      visit book_path(@book_7)

      within "nav" do
        click_link("Browse All Books")
      end

      expect(current_path).to eq(books_path)
    end
  end

  describe "when the year_published is negative" do
    it "shows BC" do
      book_8 = Book.create!(title: "The Republic", page_count: 416, year_published: -380, thumbnail: "https://images.gr-assets.com/books/1386925655l/30289.jpg")

      visit book_path(book_8)

      expect(page).to have_content("Published in #{-book_8.year_published} BC")
    end
  end
end
