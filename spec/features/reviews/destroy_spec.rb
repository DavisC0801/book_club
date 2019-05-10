require "rails_helper"

RSpec.describe "As a Visitor" do
  before(:each) do
    book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
    book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
    @user_1 = User.create(username: "Chris Davis")
    @review_1 = book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: @user_1)
    @review_2 = book_2.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: @user_1)
    @review_3 = book_1.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: @user_1)
  end
  describe "when I visit a user's show page" do
    it "shows me a button to delete each review" do
      visit user_path(@user_1)

      expect(current_path).to eq(user_path(@user_1))

      within("#review-#{@review_1.id}-info") do
        expect(page).to have_button("Delete Review")
      end

      within("#review-#{@review_2.id}-info") do
        expect(page).to have_button("Delete Review")
      end

      within("#review-#{@review_3.id}-info") do
        expect(page).to have_button("Delete Review")
      end
    end
  end

  describe "when I delete a review" do

    it "returns me to the user's show page" do
      visit user_path(@user_1)

      within("#review-#{@review_1.id}-info") do
        click_button("Delete Review")
      end

      expect(current_path).to eq(user_path(@user_1))
    end

    it "does not show me the removed review" do
      visit user_path(@user_1)

      within("#review-#{@review_1.id}-info") do
        click_button("Delete Review")
      end


      expect(page).to_not have_content(@review_1.title)
      expect(page).to_not have_content("Rating: #{@review_1.rating}/5")
      expect(page).to_not have_content(@review_1.text)
      expect(page).to have_content(@review_2.title)
      expect(page).to have_content("Rating: #{@review_2.rating}/5")
      expect(page).to have_content(@review_2.text)
      expect(page).to have_content(@review_3.title)
      expect(page).to have_content("Rating: #{@review_3.rating}/5")
      expect(page).to have_content(@review_3.text)

      expect(Review.all).to_not include(@review_1)
      expect(Review.all).to include(@review_2)
      expect(Review.all).to include(@review_3)
    end
  end
end
