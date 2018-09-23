Rails.application.routes.draw do
  resources :memberships
  resources :wine_clubs
  resources :users
  resources :wines
  resources :wineries
  resources :ratings
  root 'wineries#index'
  get 'kaikki_viinit', to: 'wines#index'
  #get 'ratings', to: 'ratings#index'
  #get 'ratings/new', to: 'ratings#new'
  #post 'ratings', to: 'ratings#create'
  resources :ratings, only: [:index, :new, :create, :destroy]
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  resource :session, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
