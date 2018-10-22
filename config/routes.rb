Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :wine_clubs
  resources :users
  resources :users do 
    post 'toggle_closed', on: :member
  end

  resources :wines
  
  resources :wineries
  resources :wineries do 
    post 'toggle_activity', on: :member
  end

  resources :ratings
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  root 'wineries#index'

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  
  resources :places, only: [:index, :show]
  get 'places', to: 'places#index'
  post 'places', to: 'places#search'

  get 'winelist', to:'wines#list'
  get 'winerylist', to:'wineries#list'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
