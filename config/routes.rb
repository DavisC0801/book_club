Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "books#index"
  resources :books, only: [:index, :show, :new]
  resources :authors, only: :show
  resources :users, only: :show
end
