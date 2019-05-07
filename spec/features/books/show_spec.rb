require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
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
  end

  it "loads the page" do
    visit "/books/#{@book_1.id}"

    expect(page.status_code).to eq(200)
    expect(current_path).to eq("/books/#{@book_1.id}")
  end

  it "shows information for a particular book" do
    visit "/books/#{@book_1.id}"

    within "#book-show" do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@author_1.name)
      expect(page).to have_content(@author_2.name)
      expect(page).to have_content("#{@book_1.page_count} pages")
      expect(page).to have_content("Published in #{@book_1.year_published}")
      expect(page).to have_css("img[src*='#{@book_1.thumbnail}']")

      expect(page).to_not have_content(@book_2.title)
    end

    within "#review-list" do
      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_1.user.username)
      expect(page).to have_content(@review_1.rating)
      expect(page).to have_content(@review_1.text)

      expect(page).to_not have_content(@review_2.title)
      expect(page).to_not have_content(@review_2.user.username)
      expect(page).to_not have_content(@review_2.rating)
      expect(page).to_not have_content(@review_2.text)
    end
  end
end
