require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :username}
  end

  describe "relationships" do
    it {should have_many :reviews}
  end

  describe "class methods" do
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

    it "sorts users by review count" do
      expect(User.sort_by_review_count).to eq([@user_4, @user_3, @user_1, @user_5, @user_2])
      expect(User.sort_by_review_count(false)).to eq([@user_2, @user_5, @user_1, @user_3, @user_4])
    end

    it "finds the X users with the most reviews" do
      expect(User.most_reviews(5)).to eq([@user_2, @user_5, @user_1, @user_3, @user_4])
      expect(User.most_reviews(3)).to eq([@user_2, @user_5, @user_1])
      expect(User.most_reviews(1)).to eq([@user_2])
    end
  end

  describe "instance methods" do
    before :each do
      @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      @book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      @book_3 = Book.create!(title: "The Moonstone", page_count: 528, year_published: 1868, thumbnail: "https://upload.wikimedia.org/wikipedia/commons/2/26/The_Moonstone_1st_ed.jpg")
      @user_1 = User.create(username: "Chris Davis")
    end

    it "provides a count of reviews" do
      expect(@user_1.reviews_count).to eq(0)
      review_1 = @book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: @user_1)
      expect(@user_1.reviews_count).to eq(1)
      review_2 = @book_2.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: @user_1)
      expect(@user_1.reviews.count).to eq(2)
    end

    it "sorts reviews by date" do
      travel 1.day
      review_1 = @book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: @user_1)
      travel_back
      review_2 = @book_2.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: @user_1)
      travel 2.day
      review_3 = @book_3.reviews.create!(title: "This book is OK.", rating: 3, text: "Read it if you want.", user: @user_1)

      expect(@user_1.sorted_reviews("date-desc").to_a).to eq([review_3, review_1, review_2])
      expect(@user_1.sorted_reviews("date-asc").to_a).to eq([review_2, review_1, review_3])
      expect(@user_1.sorted_reviews("testing_sad_path").to_a).to eq([review_1, review_2, review_3])
      expect(@user_1.sorted_reviews(nil).to_a).to eq([review_1, review_2, review_3])
    end
  end
end
