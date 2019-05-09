require "rails_helper"

RSpec.describe "As a visitor" do
  describe "when I visit the book index page" do
    it "has a link to take me to the new book path" do
      visit books_path

      click_link("Add new book")

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(new_book_path)
    end
  end

  describe "when I am at the new book form" do
    before :each do
      @title = "The Illiad"
      @year_published = 850
      @page_count = 443
      @thumbnail = "https://images.gr-assets.com/books/1388188509l/1371.jpg"
      @authors = "Homer"
    end

    it "allows users to input information and create a book" do
      visit new_book_path

      fill_in :book_title, with: @title
      fill_in :book_year_published, with: @year_published
      fill_in :book_page_count, with: @page_count
      fill_in :book_thumbnail, with: @thumbnail
      fill_in :book_authors, with: @authors

      click_button "Create Book"

      new_book = Book.last
      expect(current_path).to eq(book_path(new_book))

      within "#book-show" do
        expect(page).to have_content(@title)
        expect(page).to have_content(@authors)
        expect(page).to have_content("#{@page_count} pages")
        expect(page).to have_content("Published in #{@year_published}")
        expect(page).to have_css("img[src*='#{@thumbnail}']")
      end

      within "#review-list" do
        expect(page).to have_content("This book has no reviews yet.")
      end
    end

    it "converts title to title case" do
      visit new_book_path

      fill_in :book_title, with: "the illiad"
      fill_in :book_year_published, with: @year_published
      fill_in :book_page_count, with: @page_count
      fill_in :book_thumbnail, with: @thumbnail
      fill_in :book_authors, with: @authors

      click_button "Create Book"

      new_book = Book.last

      within "#book-show" do
        expect(page).to have_content(@title)
      end
    end

    it "confirms book titles are unique" do
      visit new_book_path

      book_1 = Book.create(title: @title, page_count: 100, year_published: 800, thumbnail: @thumbnail)

      fill_in :book_title, with: @title
      fill_in :book_year_published, with: @year_published
      fill_in :book_page_count, with: @page_count
      fill_in :book_thumbnail, with: @thumbnail
      fill_in :book_authors, with: @authors

      click_button "Create Book"

      #todo add flash message -
      #this is comparing that a new book is not created by the form.
      expect(book_1).to eq(Book.last)
    end

    it "can add multiple authors to a single book" do

    end

    it "converts author names to title case" do
      visit new_book_path

      fill_in :book_title, with: "the illiad"
      fill_in :book_year_published, with: @year_published
      fill_in :book_page_count, with: @page_count
      fill_in :book_thumbnail, with: @thumbnail
      fill_in :book_authors, with: @authors

      click_button "Create Book"

      new_book = Book.last

      within "#book-show" do
        expect(page).to have_content(@authors)
      end
    end

    it "confirms author names are unique in the system" do

    end

    it "sets a default image if none is given" do

    end
  end
end
