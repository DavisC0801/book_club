Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root to: "welcome#index"
  get '/', to: "welcome#index", as: :root

  # resources :books, only: [:index, :show, :new, :create, :destroy] do
  #   resources :reviews, only: [:new, :create]
  # end

  get '/books/:book_id/reviews/new', to: "reviews#new", as: :new_book_review
  post '/books/:book_id/reviews', to: "reviews#create", as: :book_reviews

  get '/books', to: "books#index", as: :books
  get '/books/new', to: "books#new", as: :new_book
  get '/books/:id', to: "books#show", as: :book
  post '/books', to: "books#create"
  delete '/books/:id', to: "books#destroy"

  resources :reviews, only: :destroy
  resources :authors, only: [:show, :destroy]
  resources :users, only: :show
end
