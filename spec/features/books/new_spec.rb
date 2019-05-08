require "rails_helper"

RSpec.describe "As a visitor" do
  describe "when I visit the book index page" do
    it "has a link to take me to the new book path" do
      visit books_path

      click_link("Add new book")

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(new_book)
    end
  end
end
