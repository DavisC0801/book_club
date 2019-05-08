require "rails_helper"

RSpec.describe "as a visitor" do
  describe "when I click on a user's name for any book review" do
    before :each do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      author_1 = @book_1.authors.create!(name: "Wilkie Collins")
      author_2 = @book_1.authors.create!(name: "Charles Dickens")
      @user_1 = User.create(username: "Chris Davis")
      @user_2 = User.create(username: "Alexandra Chakeres")
      @review_1 = @book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: @user_1)
      @review_2 = @book_1.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: @user_2)
    end

    it "i am taken to a show page for that user." do
      visit book_path(@book_1)

      click_link("#{@user_1.username}")

      expect(current_path).to eq(user_path(@user_1))
    end

    it "shows all information for all reviews the user has written" do
      # - the title of the review
      # - the description of the review
      # - the rating of the review
      # - the title of the book
      # - the thumbnail image for the book
      # - the date the review was written
    end
  end
end
