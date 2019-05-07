class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :page_count
  validates_presence_of :year_published
end
