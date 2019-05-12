require "rails_helper"

RSpec.describe "As a visitor" do
  describe "when I visit the welcome index" do
    it "doesn't show the navigation bar" do
      visit root_path

      expect(page).to_not have_link("Home")
      expect(page).to_not have_link("Browse All Books")
    end

    it "has a link to go to the books index" do
      visit root_path

      click_link("click here to enter")

      expect(current_path).to eq(books_path)
    end
  end
end