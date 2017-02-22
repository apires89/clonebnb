Rails.application.routes.draw do
mount Attachinary::Engine => "/attachinary"

  resources :rooms #do
    #resources :photos
  resources :bookings
  resources :ratings

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
