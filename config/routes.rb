Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # we have to tell devise now not to use its default controller, we want to use our own
  devise_for :users, controllers: {registrations: 'registrations'}
  get 'fetch', to: 'restaurants#fetch'
  get 'dashboard', to: 'pages#dashboard'
  get 'fetch_custom_city', to: 'restaurants#fetch_custom_city'
  root 'pages#home'
end
