require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "book show statistics" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @user_1 = User.create(username: "Chris Davis")
      @user_2 = User.create(username: "Alexandra Chakeres")
      @user_3 = User.create(username: "User 3")
      @user_4 = User.create(username: "User 4")
      @user_5 = User.create(username: "User 5")
      @review_1 = @book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: @user_1)
      @review_2 = @book_1.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: @user_2)
      @review_3 = @book_1.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: @user_3)
      @review_4 = @book_1.reviews.create!(title: "four stars", rating: 4, text: "Good", user: @user_4)
      @review_5 = @book_1.reviews.create!(title: "two stars", rating: 2, text: "not good", user: @user_5)
    end

    it "shows the 3 reviews with the highest ratings" do
      visit book_path(@book_1)

      within "#statistics" do
        expect(page).to have_content("Statistics")

        within "#highest-ratings" do
          expect(page).to have_content("Top 3 Reviews")
          expect(page.all("li")[0]).to have_content(@review_1.title)
          expect(page.html).to include("style=\"width:#{@review_1.rating_percentage}%;\"")
          expect(page.all("li")[0]).to have_link(@review_1.user.username)
          expect(page.all("li")[1]).to have_content(@review_4.title)
          expect(page.html).to include("style=\"width:#{@review_4.rating_percentage}%;\"")
          expect(page.all("li")[1]).to have_link(@review_4.user.username)
          expect(page.all("li")[2]).to have_content(@review_3.title)
          expect(page.html).to include("style=\"width:#{@review_3.rating_percentage}%;\"")
          expect(page.all("li")[2]).to have_link(@review_3.user.username)
          expect(page).to_not have_content(@review_2.title)
        end
      end
    end

    it "shows the 3 reviews with the lowest ratings" do
      visit book_path(@book_1)

      within "#statistics" do
        within "#lowest-ratings" do
          expect(page).to have_content("Bottom 3 Reviews")
          expect(page.all("li")[0]).to have_content(@review_2.title)
          expect(page.html).to include("style=\"width:#{@review_2.rating_percentage}%;\"")
          expect(page.all("li")[0]).to have_link(@review_2.user.username)
          expect(page.all("li")[1]).to have_content(@review_5.title)
          expect(page.html).to include("style=\"width:#{@review_5.rating_percentage}%;\"")
          expect(page.all("li")[1]).to have_link(@review_5.user.username)
          expect(page.all("li")[2]).to have_content(@review_3.title)
          expect(page.html).to include("style=\"width:#{@review_3.rating_percentage}%;\"")
          expect(page.all("li")[2]).to have_link(@review_3.user.username)
          expect(page).to_not have_content(@review_1.title)
        end
      end
    end

    it "shows the average rating" do
      visit book_path(@book_1)

      within "#statistics" do
        within "#average-rating" do
          expect(page).to have_content("Average Rating:")
          expect(page.html).to include("style=\"width:#{@book_1.rating_percentage}%;\"")
        end
      end
    end
  end

  describe "book show statistics with partial data" do
    before(:each) do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @user_1 = User.create(username: "Chris Davis")
      @review_1 = @book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: @user_1)
    end

    it "top reviews when <3 reviews" do
      visit book_path(@book_1)

      within "#statistics" do
        within "#highest-ratings" do
          expect(page).to have_content(@review_1.title)
          expect(page.all("li").count).to eq(1)
        end
      end
    end

    it "bottom reviews when <3 reviews" do
      visit book_path(@book_1)

      within "#statistics" do
        within "#lowest-ratings" do
          expect(page).to have_content(@review_1.title)
          expect(page.all("li").count).to eq(1)
        end
      end
    end
  end

  describe "book show statistics with no data" do
    it "shows a message when the book has no reviews" do
      book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")

      visit book_path(book_1)

      within "#statistics" do
        expect(page).to have_content("This book doesn't have any reviews yet.")
        expect(page).to_not have_content("Top 3 Reviews")
        expect(page).to_not have_content("Bottom 3 Reviews")
        expect(page).to_not have_content("Average Rating")
      end
    end
  end
end