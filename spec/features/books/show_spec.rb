require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  before(:each) do
    @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
    @author_1 = @book_1.authors.create!(name: "Wilkie Collins")
    @author_2 = @book_1.authors.create!(name: "Charles Dickens")
  end

  it "loads the page" do
    visit "/books/#{@book_1.id}"

    expect(page.status_code).to eq(200)
    expect(current_path).to eq("/books/#{@book_1.id}")
  end
end