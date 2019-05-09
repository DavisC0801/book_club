require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :username}
  end

  describe "relationships" do
    it {should have_many :reviews}
  end

  describe "instance methods" do
    before :each do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      @user_1 = User.create(username: "Chris Davis")
    end

    it "provides a count of reviews" do
      expect(@user_1.reviews_count).to eq(0)
      review_1 = @book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: @user_1)
      expect(@user_1.reviews_count).to eq(1)
      review_2 = @book_2.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: @user_1)
      expect(@user_1.reviews.count).to eq(2)
    end
  end
end
