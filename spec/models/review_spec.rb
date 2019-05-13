require "rails_helper"

RSpec.describe Review, type: :model do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :rating}
    it {should validate_presence_of :text}

    it {should validate_numericality_of(:rating).only_integer}
    it {should validate_numericality_of(:rating).is_greater_than_or_equal_to(1)}
    it {should validate_numericality_of(:rating).is_less_than_or_equal_to(5)}
  end

  describe "relationships" do
    it {should belong_to :book}
    it {should belong_to :user}
  end

  describe "instance methods" do
    before :each do
      book_1 = Book.create!(title: "The Illiad", page_count: 443, year_published: 850, thumbnail: "https://images.gr-assets.com/books/1388188509l/1371.jpg")
      book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 600, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      user_1 = User.create!(username: "Chris Davis")
      user_2 = User.create!(username: "Alexandra Chakersa")
      @review_1 = book_1.reviews.create!(title: "Terrible", rating: 1, text: "This was the worst book I've ever read.", user: user_1)
      @review_2 = book_1.reviews.create!(title: "Great", rating: 5, text: "It's awesome!", user: user_2)
      @review_3 = book_2.reviews.create!(title: "Not good", rating: 3, text: "I wouldn't recommend it.", user: user_1)
      @review_4 = book_2.reviews.create!(title: "Not bad", rating: 4, text: "Pretty good.", user: user_2)
    end

    it "gives each rating a percentage" do
      expect(@review_1.rating_percentage).to eq(20)
      expect(@review_2.rating_percentage).to eq(100)
      expect(@review_3.rating_percentage).to eq(60)
      expect(@review_4.rating_percentage).to eq(80)
    end
  end
end
