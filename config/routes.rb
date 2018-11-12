Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => "registrations",
    :sessions => "sessions"
  }
  
  authenticated do
    as :user do
      root :to => "users#show"
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
    end
    resources :posts
  end

  resources :relationships, only: [:create, :destroy]

  get 'book_search', to: 'books#book_search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
