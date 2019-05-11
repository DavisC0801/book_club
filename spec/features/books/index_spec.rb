require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do

  describe "when there are no books created" do
    it "Has no data" do
      visit books_path

      expect(page).to_not have_content("Published in")
      expect(page).to_not have_content("pages")
    end
  end

  describe "when I visit the books index page" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      @author_1 = @book_1.authors.create!(name: "Wilkie Collins")
      @author_2 = @book_1.authors.create!(name: "Charles Dickens")
      @author_3 = @book_2.authors.create!(name: "Harper Lee")
      @user_1 = User.create!(username: "Chris Davis")
      @user_2 = User.create!(username: "Alexandra Chakeres")
      @review_1 = @book_1.reviews.create!(title: "Terrible", rating: 1, text: "This was the worst book I've ever read.", user: @user_1)
      @review_2 = @book_1.reviews.create!(title: "Not good", rating: 2, text: "I wouldn't recommend it.", user: @user_2)
    end

    it "loads the page" do
      visit books_path

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(books_path)
    end

    it "shows book information for all books" do
      visit books_path

      within "#book-#{@book_1.id}" do
        expect(page).to have_link(@book_1.title)
        expect(page).to have_content(@author_1.name + ", " + @author_2.name)
        expect(page).to have_link(@author_1.name)
        expect(page).to have_link(@author_2.name)
        expect(page).to have_content("#{@book_1.page_count} pages")
        expect(page).to have_content("Published in #{@book_1.year_published}")
        expect(page).to have_css("img[src*='#{@book_1.thumbnail}']")
      end

      within "#book-#{@book_2.id}" do
        expect(page).to have_link(@book_2.title)
        expect(page).to have_link(@author_3.name)
        expect(page).to_not have_content(",")
        expect(page).to have_content("#{@book_2.page_count} pages")
        expect(page).to have_content("Published in #{@book_2.year_published}")
        expect(page).to have_css("img[src*='#{@book_2.thumbnail}']")
      end
    end

    describe "when a book has no author" do
      it "says author is unknown" do
        book_3 = Book.create!(title: "The Frozen Deep, A play", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")

        visit books_path

        within "#book-#{book_3.id}" do
          expect(page).to have_content("Author(s): unknown")
        end
      end
    end

    it "shows each book's average rating" do
      visit books_path

      within "#book-#{@book_1.id}" do
        avg_rating = (@review_1.rating + @review_2.rating) / 2.0
        expect(page).to have_content("Average Rating: #{avg_rating.round(1)}")
      end

      within "#book-#{@book_2.id}" do
        # Note: book 2 has no reviews
        expect(page).to have_content("Average Rating: 0")
      end
    end

    it "shows how many reviews each book has" do
      visit books_path

      within "#book-#{@book_1.id}" do
        expect(page).to have_content("#{@book_1.reviews.count} reviews")
      end

      within "#book-#{@book_2.id}" do
        expect(page).to have_content("0 reviews")
      end
    end

    describe "navigation bar" do
      it "has a link to go to the homepage" do
        visit books_path

        within "nav" do
          click_link("Home")
        end

        expect(current_path).to eq(root_path)
      end

      it "has a link to go to the books index" do
        visit books_path

        within "nav" do
          click_link("Browse All Books")
        end

        expect(current_path).to eq(books_path)
      end
    end
  end
end
