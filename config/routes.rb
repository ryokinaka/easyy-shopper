Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create]
  
  resources :items, only: [:show, :new, :create] do
    member do
      get :purchase
      post :buying
      get :done
    end
  end
    
  resources :wants, only: [:index, :create, :destroy]
end
