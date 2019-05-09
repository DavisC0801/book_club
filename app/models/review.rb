class Review < ApplicationRecord
  attr_accessor :username
  
  belongs_to :book
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :text
end
