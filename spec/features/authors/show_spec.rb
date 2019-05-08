require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when there is an author with the id matching the URI" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      @author_1 = @book_1.authors.create!(name: "Wilkie Collins")
      @author_2 = @book_1.authors.create!(name: "Charles Dickens")
      @author_3 = @book_2.authors.create!(name: "Harper Lee")
      @book_3 = @author_1.books.create!(title: "The Moonstone", page_count: 528, year_published: 1868, thumbnail: "https://en.wikipedia.org/wiki/File:The_Moonstone_1st_ed.jpg")
      user_1 = User.create(username: "Chris Davis")
      user_2 = User.create(username: "Alexandra Chakeres")
      @review_1 = @book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: user_1)
      @review_2 = @book_2.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: user_2)
      @review_3 = @book_1.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: user_2)
    end

    it "loads the page" do
      visit author_path(@author_1)

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(author_path(@author_1))
    end

    # it "shows information for a particular author" do
    #   visit author_path(@author_1)
    #
    #   within "#author-show" do
    #     expect(page).to have_content(@book_1.title)
    #     expect(page).to have_content(@author_1.name)
    #     expect(page).to have_content(@author_2.name)
    #     expect(page).to have_content("#{@book_1.page_count} pages")
    #     expect(page).to have_content("Published in #{@book_1.year_published}")
    #     expect(page).to have_css("img[src*='#{@book_1.thumbnail}']")
    #
    #     expect(page).to_not have_content(@book_2.title)
    #   end
    #
    #   within "#book-list" do
    #     expect(page).to have_content("Books")
    #
    #     within "#book-#{@book_1.id}" do
    #       expect(page).to have_content(@review_1.title)
    #       expect(page).to have_content("Written by: #{@review_1.user.username}")
    #       expect(page).to have_content("Rating: #{@review_1.rating}/5")
    #       expect(page).to have_content(@review_1.text)
    #     end
    #
    #     within "#review-#{@review_3.id}" do
    #       expect(page).to have_content(@review_3.title)
    #       expect(page).to have_content("Written by: #{@review_3.user.username}")
    #       expect(page).to have_content("Rating: #{@review_3.rating}/5")
    #       expect(page).to have_content(@review_3.text)
    #     end
    #
    #     expect(page).to_not have_content(@review_2.title)
    #     expect(page).to_not have_content("This book has no reviews yet.")
    #     expect(page).to_not have_content("Author(s): unknown")
    #   end
    # end
  end

  describe "when there is no author with the id matching the URI" do
    it "redirects to the authors index" do
      author_4 = Author.create!(name: "Bob")

      visit author_path(author_4.id + 50)

      expect(current_path).to eq(authors_path)
    end
  end

  describe "when the author has no books" do
    it "displays a message as such" do
      author_5 = Author.create!(name: "Sally")

      visit author_path(author_5)

      within "#book-list" do
        expect(page).to have_content("This author has no books in the database.")
      end
    end
  end
end
