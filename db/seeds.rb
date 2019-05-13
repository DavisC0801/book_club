# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Review.destroy_all
User.destroy_all
BookAuthor.destroy_all
Author.destroy_all
Book.destroy_all

book_1 = Book.create!(title: "The Frozen Deep", page_count: 106, year_published: 1874, thumbnail: "https://images.gr-assets.com/books/1328728986l/1009218.jpg")
book_2 = Book.create!(title: "To Kill a Mockingbird", page_count: 281, year_published: 1960, thumbnail: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG")
author_1 = book_1.authors.create!(name: "Wilkie Collins")
author_2 = book_1.authors.create!(name: "Charles Dickens")
author_3 = book_2.authors.create!(name: "Harper Lee")
book_3 = author_3.books.create!(title: "Go Set a Watchman", page_count: 278, year_published: 2015, thumbnail: "https://upload.wikimedia.org/wikipedia/en/4/4e/US_cover_of_Go_Set_a_Watchman.jpg")
book_4 = Book.create!(title: "Beowulf", page_count: 213, year_published: 536, thumbnail: "https://images.gr-assets.com/books/1327878125l/52357.jpg")
book_5 = Book.create!(title: "The Explorers Guild", page_count: 784, year_published: 2015, thumbnail: "https://b9r8e6p9.stackpathcdn.com/wp-content/uploads/2016/08/The-Explorers-Guild.jpg")
book_6 = author_2.books.create!(title: "A Tale of Two Cities", page_count: 341, year_published: 1859, thumbnail: "https://upload.wikimedia.org/wikipedia/commons/3/3c/Tales_serial.jpg")
author_4 = book_5.authors.create!(name: "Kevin Costner")
author_5 = book_5.authors.create!(name: "Jon Baird")
author_6 = book_5.authors.create!(name: "Rick Ross")
user_1 = User.create(username: "Chris Davis")
user_2 = User.create(username: "Alexandra Chakeres")
review_1 = book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: user_1)
review_2 = book_2.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: user_2)
review_3 = book_1.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: user_2)
