Rails.application.routes.draw do
  get 'books/new'
  get 'books/index'
  get 'books/show'
  get 'books/edit'
  devise_for :users
  root to: 'home#top'
  get "home/about"=> "home#about", as: "about"
  
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
