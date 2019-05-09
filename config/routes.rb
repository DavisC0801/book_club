Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "books#index"
<<<<<<< HEAD
  resources :books, only: [:index, :show, :new]
=======
  resources :books, only: [:index, :show]
  resources :authors, only: :show
>>>>>>> 399faa9319b58991bf93df929889c33559b917bd
  resources :users, only: :show
end
