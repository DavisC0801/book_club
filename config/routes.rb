Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index", as: "root"

  post "/books/:book_id/reviews", to: "reviews#create", as: "book_reviews"
  get "books/:book_id/reviews/new", to: "reviews#new", as: "new_book_review"

  get "/books", to: "books#index", as: "books"
  post "/books", to: "books#create"
  get "/books/new", to: "books#new", as: "new_book"
  get "/books/:id", to: "books#show", as: "book"
  delete "books/:id", to: "books#destroy"

  delete "reviews/:id", to: "reviews#destroy", as: "review"

  get "users/:id", to: "users#show", as: "user"

  get "authors/:id", to: "authors#show", as: "author"
  delete "authors/:id", to: "authors#destroy"
end
