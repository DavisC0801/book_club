require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the books index page" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      # TO DO: add author(s)
    end

    it "loads the page" do
      visit "/books"

      expect(page.status_code).to eq(200)
      expect(current_path).to eq("/books")
    end

    it "shows book information for all books" do
      visit "/books"

      within "#book-#{@book_1.id}" do
        expect(page).to have_content(@book_1.title)
        # expect(page).to have_content(@book_1.authors.first.name)
        # expect(page).to have_content(@book_1.authors.second.name)
        expect(page).to have_content("#{@book_1.page_count} pages")
        expect(page).to have_content("Published in #{@book_1.year_published}")
        expect(page).to have_css("img[src*='#{@book_1.thumbnail}']")
      end
    end
  end
end