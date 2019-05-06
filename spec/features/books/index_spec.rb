require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit the books index page" do
    it "loads the page" do
      visit "/books"

      expect(page.status_code).to eq(200)
      expect(current_path).to eq("/books")
    end
  end
end