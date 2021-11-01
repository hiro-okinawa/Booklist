Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: 'users#index'
  
  get 'users/:id/books', to: 'users#show'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :users, exept: [:index, :new, :show] do
    member do
      resources :books, only: [:index, :create, :update, :destroy]
      get :have_been_read
      get :now_reading
      get :wants_to_read
    end
  end
end
