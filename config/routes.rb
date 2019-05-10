Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "books#index"

  resources :books, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: :destroy  
  resources :authors, only: [:show, :destroy]
  resources :users, only: :show
end
