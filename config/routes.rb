Rails.application.routes.draw do
mount Attachinary::Engine => "/attachinary"
  get '/user/profile',  to: 'users#show', as: 'user_profile'
  resources :rooms do
    resources :bookings, only: [ :new, :create ]
  end
  #resources :bookings
  resources :ratings

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
