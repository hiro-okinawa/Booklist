Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'users#index'
  get 'signup', to: 'users#new'
  resources :users, exept: [:index, :new] 
end
