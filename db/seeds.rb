# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
author_1 = book_1.authors.create!(name: "Wilkie Collins")
author_2 = book_1.authors.create!(name: "Charles Dickens")
author_3 = book_2.authors.create!(name: "Harper Lee")
user_1 = User.create(username: "Chris Davis")
user_2 = User.create(username: "Alexandra Chakeres")
review_1 = book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: user_1)
review_2 = book_2.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: user_2)
review_3 = book_1.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: user_2)
