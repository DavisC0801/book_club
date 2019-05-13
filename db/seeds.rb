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
author_7 = Author.create!(name: "E. L. James")
book_7 = author_7.books.create!(title: "Fifty Shades of Grey", page_count: 514, year_published: 2011, thumbnail: "https://upload.wikimedia.org/wikipedia/en/5/5e/50ShadesofGreyCoverArt.jpg")
book_8 = author_5.books.create!(title: "Valiant, He Endured: 17 Sci-Fi Myths of Insolent Grit (There Will Be Liberty Book 2)", page_count: 219, year_published: 2016, thumbnail: "https://images-na.ssl-images-amazon.com/images/I/51sZdiQa3pL.jpg")
author_8 = book_8.authors.create!(name: "George Donnelly")
author_9 = book_8.authors.create!(name: "Michael DiBaggio")
author_10 = book_8.authors.create!(name: "Allan Davis")
user_1 = User.create(username: "Chris Davis")
user_2 = User.create(username: "Alexandra Chakeres")
user_3 = User.create(username: "Jack Skellington")
user_4 = User.create(username: "Santa Claus")
user_5 = User.create(username: "Jesus Christ")
review_1 = book_1.reviews.create!(title: "This book rocks!", rating: 5, text: "Read it!", user: user_1)
review_2 = book_2.reviews.create!(title: "This book sucks!", rating: 1, text: "Don't read it!", user: user_2)
review_3 = book_1.reviews.create!(title: "It's OK.", rating: 3, text: "Meh", user: user_2)
review_4 = book_2.reviews.create!(title: "four stars", rating: 4, text: "Good", user: user_5)
review_5 = book_4.reviews.create!(title: "two stars", rating: 2, text: "not good", user: user_2)
review_6 = book_4.reviews.create!(title: "Alright", rating: 3, text: "Not the best", user: user_5)
review_7 = book_2.reviews.create!(title: "nice", rating: 4, text: "I like it", user: user_3)
review_8 = book_5.reviews.create!(title: "great", rating: 4, text: "read it!", user: user_1)
review_9 = book_5.reviews.create!(title: "fantastic", rating: 5, text: "the best book ever", user: user_5)
review_10 = book_5.reviews.create!(title: "spectacular", rating: 5, text: "spot on", user: user_2)
review_11 = book_7.reviews.create!(title: "just no", rating: 1, text: "skip it", user: user_2)
review_12 = book_8.reviews.create!(title: "Extremely enjoyable collection!", rating: 5, text: "I love well done anthologies, but there are so many bad ones! This is one of the good ones and it does what sci-fi was made to do: examine complex social and ethical issues in a thought provoking and entertaining way. I laughed out loud at several of the stories, very funny! And some of them made me pause and mull over what I had just read. The liberty themes came through each one, some subtle others more in your face. Loved it! High caliber authors, good flow from story to story.", user: user_1)
