require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "book index statistics" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 600, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      @book_3 = Book.create!(title: "50 Shades of Grey", page_count: 514, year_published: 2011, thumbnail: "https://upload.wikimedia.org/wikipedia/en/5/5e/50ShadesofGreyCoverArt.jpg")
      @book_4 = Book.create!(title: "Title 4", page_count: 600, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/5/5e/50ShadesofGreyCoverArt.jpg")
      @book_5 = Book.create!(title: "Title 5", page_count: 514, year_published: 2011, thumbnail: "https://upload.wikimedia.org/wikipedia/en/5/5e/50ShadesofGreyCoverArt.jpg")
      @user_1 = User.create(username: "Chris Davis")
      @user_2 = User.create(username: "Alexandra Chakeres")
      @user_3 = User.create(username: "User 3")
      @user_4 = User.create(username: "User 4")
      @user_5 = User.create(username: "User 5")
      @review_1 = @book_2.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: @user_1)
      @review_2 = @book_1.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: @user_2)
      @review_3 = @book_2.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: @user_2)
      @review_4 = @book_2.reviews.create!(title: "four stars", rating: 4, text: "Good", user: @user_5)
      @review_5 = @book_4.reviews.create!(title: "two stars", rating: 2, text: "not good", user: @user_2)
      @review_6 = @book_4.reviews.create!(title: "Alright", rating: 3, text: "Not the best", user: @user_5)
      @review_7 = @book_2.reviews.create!(title: "nice", rating: 4, text: "I like it", user: @user_3)
      @review_8 = @book_5.reviews.create!(title: "great", rating: 4, text: "read it!", user: @user_1)
      @review_9 = @book_5.reviews.create!(title: "fantastic", rating: 5, text: "the best book ever", user: @user_5)
      @review_10 = @book_5.reviews.create!(title: "spectacular", rating: 5, text: "spot on", user: @user_2)
    end

    it "shows the 3 highest rated books" do
      visit books_path

      within "#statistics" do
        expect(page).to have_content("Statistics")

        within "#highest-rated" do
          expect(page.all("li")[0]).to have_content(@book_5.title)
          expect(page.all("li")[0]).to have_content(@book_5.average_rating)
          expect(page.all("li")[1]).to have_content(@book_2.title)
          expect(page.all("li")[1]).to have_content(@book_2.average_rating)
          expect(page.all("li")[2]).to have_content(@book_4.title)
          expect(page.all("li")[2]).to have_content(@book_4.average_rating)
        end
      end
    end

    it "shows the 3 lowest rated books" do
      visit books_path

      within "#statistics" do
        within "#lowest-rated" do
          expect(page.all("li")[0]).to have_content(@book_1.title)
          expect(page.all("li")[0]).to have_content(@book_1.average_rating)
          expect(page.all("li")[1]).to have_content(@book_4.title)
          expect(page.all("li")[1]).to have_content(@book_4.average_rating)
          expect(page.all("li")[2]).to have_content(@book_2.title)
          expect(page.all("li")[2]).to have_content(@book_2.average_rating)
        end
      end
    end

    it "shows the 3 users with the most reviews" do
      visit books_path

      within "#statistics" do
        within "#most-reviews" do
          expect(page.all("li")[0]).to have_content(@user_2.username)
          expect(page.all("li")[0]).to have_content(@user_2.reviews_count)
          expect(page.all("li")[1]).to have_content(@user_5.username)
          expect(page.all("li")[1]).to have_content(@user_5.reviews_count)
          expect(page.all("li")[2]).to have_content(@user_1.username)
          expect(page.all("li")[2]).to have_content(@user_1.reviews_count)
        end
      end
    end
  end
end