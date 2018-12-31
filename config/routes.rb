Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => "registrations",
    :sessions => "sessions"
  }
  
  authenticated do
    as :user do
      root :to => 'users#current_user_home'
    end
  end

  unauthenticated do
    as :user do
      root :to => "devise/sessions#new"
    end
  end

  resources :users, only: [:show, :index]  do
    member do
      get :following, :followers
      get :wish, to: 'books#wish'
      get :reading, to: 'books#reading'
      get :read, to: 'books#read'
    end
    resources :posts
    resources :books, only: [:edit, :destroy, :update]
  end

  resources :relationships, only: [:create, :destroy]
  resources :library, only: [:destroy]

  get 'book_search', to: 'books#book_search'
  get 'book_detail', to: 'books#book_detail'
  post 'book', to: 'books#create'
  get 'library_search', to: 'library#library_search'
  get 'library_detail', to: 'library#library_detail'
  post 'library', to: 'library#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
