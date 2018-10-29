Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => "registrations"
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

  resources :users, only: [:show] do

  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
