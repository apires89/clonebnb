Rails.application.routes.draw do
mount Attachinary::Engine => "/attachinary"
  get 'rooms/new'

  get 'rooms/show'

  get 'rooms/index'

  get 'rooms/create'

  get 'rooms/update'

  get 'rooms/edit'

 resources :bookings

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
