require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the books index page" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      @author_1 = @book_1.authors.create!(name: "Wilkie Collins")
      @author_2 = @book_1.authors.create!(name: "Charles Dickens")
      @author_3 = @book_2.authors.create!(name: "Harper Lee")
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
        expect(page).to have_content(@author_1.name + ", " + @author_2.name)
        expect(page).to have_content("#{@book_1.page_count} pages")
        expect(page).to have_content("Published in #{@book_1.year_published}")
        expect(page).to have_css("img[src*='#{@book_1.thumbnail}']")
      end

      within "#book-#{@book_2.id}" do
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content(@author_3.name)
        expect(page).to_not have_content(",")
        expect(page).to have_content("#{@book_2.page_count} pages")
        expect(page).to have_content("Published in #{@book_2.year_published}")
        expect(page).to have_css("img[src*='#{@book_2.thumbnail}']")
      end
    end
  end
end