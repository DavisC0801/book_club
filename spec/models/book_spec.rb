require "rails_helper"

RSpec.describe Book, type: :model do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :page_count}
    it {should validate_presence_of :year_published}
    it {should validate_uniqueness_of :title}
    it {should validate_numericality_of(:year_published).only_integer}
    it {should validate_numericality_of(:year_published).is_greater_than_or_equal_to(-4000)}
    it {should validate_numericality_of(:year_published).is_less_than_or_equal_to(Time.now.year)}
    it {should validate_numericality_of(:page_count).only_integer}
    it {should validate_numericality_of(:page_count).is_greater_than_or_equal_to(1)}
  end

  describe "relationships" do
    it {should have_many :book_authors}
    it {should have_many(:authors).through(:book_authors)}
    it {should have_many :reviews}
  end

  describe "class methods" do
    describe "when destroying a book" do
      before(:each) do
        @book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
        @book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
        @author_1 = @book_1.authors.create!(name: "Wilkie Collins")
        @author_2 = @book_1.authors.create!(name: "Charles Dickens")
        @author_3 = @book_2.authors.create!(name: "Harper Lee")
        user_1 = User.create(username: "Chris Davis")
        user_2 = User.create(username: "Alexandra Chakeres")
        @review_1 = @book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: user_1)
        @review_2 = @book_2.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: user_2)
        @review_3 = @book_1.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: user_2)
      end

      it "destroys the book" do
        Book.destroy_book(@book_1.id)

        expect(Book.all).to_not include(@book_1)
        expect(Book.all).to include(@book_2)
      end

      it "destroys the book's reviews" do
        Book.destroy_book(@book_1.id)

        expect(Review.all).to_not include(@review_1)
        expect(Review.all).to include(@review_2)
        expect(Review.all).to_not include(@review_3)
      end

      it "destroys appropriate BookAuthor entries" do
        Book.destroy_book(@book_1.id)

        all_book_ids_in_book_authors = BookAuthor.pluck(:book_id)

        expect(all_book_ids_in_book_authors).to_not include(@book_1.id)
        expect(all_book_ids_in_book_authors).to include(@book_1.id)
      end
    end
  end

  describe "instance methods" do
    before(:each) do
      @book_1 = Book.create!(title: "I'm a Book", page_count: 573, year_published: 1965)
      @book_2 = Book.create!(title: "I'm also a Book", page_count: 573, year_published: 1965)
      @author_1 = @book_1.authors.create!(name: "Bob")
      @author_2 = @book_1.authors.create!(name: "Sally")
      @author_3 = @book_1.authors.create!(name: "Jane")
      @user_1 = User.create!(username: "Chris Davis")
      @review_1 = @book_2.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: @user_1)
    end

    it "counts reviews" do
      expect(@book_1.review_count).to eq(0)
      expect(@book_2.review_count).to eq(1)
    end

    it "counts authors" do
      expect(@book_1.author_count).to eq(3)
      expect(@book_2.author_count).to eq(0)
    end

    it "lists coauthors" do
      expect(@book_1.coauthors(@author_2)).to eq([@author_1, @author_3])
    end
  end
end
