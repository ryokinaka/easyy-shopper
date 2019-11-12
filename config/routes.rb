Rails.application.routes.draw do
  root to: 'items#index'
  
  resources :items, only: [:show, :new, :create, :edit, :update, :destroy] do
    member do
      get :purchase
      get :done
      get :buylist
      get :selllist
      post :pay
    end
  end
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update]
    
  resources :wants, only: [:index, :create, :destroy]
end
