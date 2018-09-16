Rails.application.routes.draw do
  resources :wines
  resources :wineries
  resources :ratings
  root 'wineries#index'
  get 'kaikki_viinit', to: 'wines#index'
  get 'ratings', to: 'ratings#index'
  get 'ratings/new', to: 'ratings#new'
  post 'ratings', to: 'ratings#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
