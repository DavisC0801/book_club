require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I click the delete button on an author's show page" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      @author_1 = @book_1.authors.create!(name: "Wilkie Collins")
      @author_2 = @book_1.authors.create!(name: "Charles Dickens")
      @author_3 = @book_2.authors.create!(name: "Harper Lee")
      @book_3 = @author_1.books.create!(title: "The Moonstone", page_count: 528, year_published: 1868, thumbnail: "https://upload.wikimedia.org/wikipedia/commons/2/26/The_Moonstone_1st_ed.jpg")
      user_1 = User.create(username: "Chris Davis")
      user_2 = User.create(username: "Alexandra Chakeres")
      @review_1 = @book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: user_1)
      @review_2 = @book_2.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: user_2)
      @review_3 = @book_1.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: user_2)
    end

    it "destroys the author and redirects to the book index page" do
      visit author_path(@author_1)
      click_button("Delete Author")

      expect(current_path).to eq(books_path)

      expect(Author.all).to include(@author_2)
      expect(Author.all).to include(@author_3)
      expect(Author.all).to_not include(@author_1)
      expect(page).to have_content(@author_3.name)
      expect(page).to_not have_content(@author_1.name)
      expect(page).to_not have_content(@author_2.name)
    end

    it "destroys the author's books" do
      visit author_path(@author_1)
      click_button("Delete Author")

      expect(Book.all).to include(@book_2)
      expect(Book.all).to_not include(@book_1)
      expect(Book.all).to_not include(@book_3)
      expect(page).to have_content(@book_2.title)
      expect(page).to_not have_content(@book_1.title)
      expect(page).to_not have_content(@book_3.title)
    end
  end
end
