require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the book index page" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 600, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      @book_3 = Book.create!(title: "50 Shades of Grey", page_count: 514, year_published: 2011, thumbnail: "https://upload.wikimedia.org/wikipedia/en/5/5e/50ShadesofGreyCoverArt.jpg")
      @author_1 = @book_1.authors.create!(name: "Wilkie Collins")
      @author_2 = @book_1.authors.create!(name: "Charles Dickens")
      @author_3 = @book_2.authors.create!(name: "Harper Lee")
      user_1 = User.create(username: "Chris Davis")
      user_2 = User.create(username: "Alexandra Chakeres")
      @review_1 = @book_2.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: user_1)
      @review_2 = @book_1.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: user_2)
      @review_3 = @book_2.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: user_2)
    end

    it "should show a link to sort books by average rating (ascending)" do
      visit books_path

      within "#sort-bar" do
        click_link "average rating (lowest to highest)"
      end

      expect(page.all(".book-info")[0]).to have_link(@book_3.title)
      expect(page.all(".book-info")[1]).to have_link(@book_1.title)
      expect(page.all(".book-info")[2]).to have_link(@book_2.title)
    end

    it "should show a link to sort books by average rating (descending)" do
      visit books_path

      within "#sort-bar" do
        click_link "average rating (highest to lowest)"
      end

      expect(page.all(".book-info")[0]).to have_link(@book_2.title)
      expect(page.all(".book-info")[1]).to have_link(@book_1.title)
      expect(page.all(".book-info")[2]).to have_link(@book_3.title)
    end

    it "should show a link to sort books by number of pages (ascending)" do
      visit books_path

      within "#sort-bar" do
        click_link "number of pages (lowest to highest)"
      end

      expect(page.all(".book-info")[0]).to have_link(@book_1.title)
      expect(page.all(".book-info")[1]).to have_link(@book_3.title)
      expect(page.all(".book-info")[2]).to have_link(@book_2.title)
    end

    it "should show a link to sort books by number of pages (descending)" do
      visit books_path

      within "#sort-bar" do
        click_link "number of pages (highest to lowest)"
      end

      expect(page.all(".book-info")[0]).to have_link(@book_2.title)
      expect(page.all(".book-info")[1]).to have_link(@book_3.title)
      expect(page.all(".book-info")[2]).to have_link(@book_1.title)
    end

    it "should show a link to sort books by number of reviews (ascending)" do
      visit books_path

      within "#sort-bar" do
        click_link "number of reviews (lowest to highest)"
      end

      expect(page.all(".book-info")[0]).to have_link(@book_3.title)
      expect(page.all(".book-info")[1]).to have_link(@book_1.title)
      expect(page.all(".book-info")[2]).to have_link(@book_2.title)
    end

    it "should show a link to sort books by number of reviews (descending)" do
      visit books_path

      within "#sort-bar" do
        click_link "number of reviews (highest to lowest)"
      end

      expect(page.all(".book-info")[0]).to have_link(@book_2.title)
      expect(page.all(".book-info")[1]).to have_link(@book_1.title)
      expect(page.all(".book-info")[2]).to have_link(@book_3.title)
    end

    it "sorting by anything else does nothing" do
      visit "#{books_path}?sort=title-asc"

      expect(page.all(".book-info")[0]).to have_link(@book_1.title)
      expect(page.all(".book-info")[1]).to have_link(@book_2.title)
      expect(page.all(".book-info")[2]).to have_link(@book_3.title)

      visit "#{books_path}?sort=zebra"

      expect(page.all(".book-info")[0]).to have_link(@book_1.title)
      expect(page.all(".book-info")[1]).to have_link(@book_2.title)
      expect(page.all(".book-info")[2]).to have_link(@book_3.title)
    end
  end

  describe "sorting edge cases" do
    it "doesn't error out when there duplicate values to sort" do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 600, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      @book_3 = Book.create!(title: "50 Shades of Grey", page_count: 514, year_published: 2011, thumbnail: "https://upload.wikimedia.org/wikipedia/en/5/5e/50ShadesofGreyCoverArt.jpg")
      @author_1 = @book_1.authors.create!(name: "Wilkie Collins")
      @author_2 = @book_1.authors.create!(name: "Charles Dickens")
      @author_3 = @book_2.authors.create!(name: "Harper Lee")
      user_1 = User.create(username: "Chris Davis")
      user_2 = User.create(username: "Alexandra Chakeres")
      @review_1 = @book_2.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: user_1)
      @review_2 = @book_1.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: user_2)
      @review_3 = @book_2.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: user_2)
      @review_4 = @book_3.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: user_2)

      visit books_path

      within "#sort-bar" do
        click_link "average rating (lowest to highest)"
      end

      expect(page).to have_link(@book_1.title)
      expect(page).to have_link(@book_2.title)
      expect(page).to have_link(@book_3.title)
    end

    it "doesn't error out when there are no books" do
      visit books_path

      within "#sort-bar" do
        click_link "average rating (lowest to highest)"
      end

      expect(page).to have_content("Sort By")
    end
  end
end
