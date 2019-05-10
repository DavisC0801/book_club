class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates_presence_of :title, :rating, :text

  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
