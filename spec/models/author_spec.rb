require "rails_helper"

RSpec.describe Author, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it {should have_many :book_authors}
    it {should have_many(:books).through(:book_authors)}
  end

  describe "instance methods" do
    before(:each) do
      @author_1 = Author.create!(name: "Wilkie Collins")
      @author_2 = Author.create!(name: "Charles Dickens")
      @book_1 = @author_1.books.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874)
      @book_2 = @author_1.books.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960)
    end

    it "counts books" do
      expect(@author_1.book_count).to eq(2)
      expect(@author_2.book_count).to eq(0)
    end
  end
end
