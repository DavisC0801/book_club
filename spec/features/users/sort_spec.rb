require "rails_helper"

RSpec.describe "As a Visitor" do
  describe "when I visit a users's show page" do
    before(:each) do
      book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
      book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
      book_3 = Book.create!(title: "The Illiad", page_count: 443, year_published: 850, thumbnail: "https://images.gr-assets.com/books/1388188509l/1371.jpg")
      @user_1 = User.create!(username: "Chris Davis")
      travel 1.day
      @review_1 = book_1.reviews.create!(title: "Terrible", rating: 1, text: "This was the worst book I've ever read.", user: @user_1)
      travel_back
      @review_2 = book_3.reviews.create!(title: "Great", rating: 5, text: "It's awesome!", user: @user_1)
      travel 2.day
      @review_3 = book_2.reviews.create!(title: "Not good", rating: 2, text: "I wouldn't recommend it.", user: @user_1)
    end

    it "should have links to sort reviews by newest and oldest" do
      visit user_path(@user_1)

      within("#sort-bar") do
        expect(page).to have_link("Sort by Oldest")
        expect(page).to have_link("Sort by Newest")
      end

      expect(current_path).to eq(user_path(@user_1))
    end

    it "sorts the page by oldest" do
      visit user_path(@user_1)

      click_link "Sort by Oldest"

      expect(page.all(".review-info")[0]).to have_content(@review_2.title)
      expect(page.all(".review-info")[0]).to have_content("Rating: #{@review_2.rating}/5")
      expect(page.all(".review-info")[0]).to have_content(@review_2.text)
      expect(page.all(".review-info")[1]).to have_content(@review_1.title)
      expect(page.all(".review-info")[1]).to have_content("Rating: #{@review_1.rating}/5")
      expect(page.all(".review-info")[1]).to have_content(@review_1.text)
      expect(page.all(".review-info")[2]).to have_content(@review_3.title)
      expect(page.all(".review-info")[2]).to have_content("Rating: #{@review_3.rating}/5")
      expect(page.all(".review-info")[2]).to have_content(@review_3.text)

      expect(current_path).to eq(user_path(@user_1))
    end

    it "sorts the page by newest" do
      visit user_path(@user_1)

      click_link "Sort by Newest"

      expect(page.all(".review-info")[0]).to have_content(@review_3.title)
      expect(page.all(".review-info")[0]).to have_content("Rating: #{@review_3.rating}/5")
      expect(page.all(".review-info")[0]).to have_content(@review_3.text)
      expect(page.all(".review-info")[1]).to have_content(@review_1.title)
      expect(page.all(".review-info")[1]).to have_content("Rating: #{@review_1.rating}/5")
      expect(page.all(".review-info")[1]).to have_content(@review_1.text)
      expect(page.all(".review-info")[2]).to have_content(@review_2.title)
      expect(page.all(".review-info")[2]).to have_content("Rating: #{@review_2.rating}/5")
      expect(page.all(".review-info")[2]).to have_content(@review_2.text)

      expect(current_path).to eq(user_path(@user_1))
    end

    it "handles junk queries" do
      visit (user_path(@user_1) + "?sort=testing")

      expect(page.all(".review-info")[0]).to have_content(@review_1.title)
      expect(page.all(".review-info")[0]).to have_content("Rating: #{@review_1.rating}/5")
      expect(page.all(".review-info")[0]).to have_content(@review_1.text)
      expect(page.all(".review-info")[1]).to have_content(@review_2.title)
      expect(page.all(".review-info")[1]).to have_content("Rating: #{@review_2.rating}/5")
      expect(page.all(".review-info")[1]).to have_content(@review_2.text)
      expect(page.all(".review-info")[2]).to have_content(@review_3.title)
      expect(page.all(".review-info")[2]).to have_content("Rating: #{@review_3.rating}/5")
      expect(page.all(".review-info")[2]).to have_content(@review_3.text)
    end
  end
end
