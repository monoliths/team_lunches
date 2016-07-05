Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # we have to tell devise now not to use its default controller, we want to use our own
  devise_for :users, controllers: {registrations: 'registrations'}

  get 'dashboard', to: 'pages#dashboard'
  root 'pages#home'
end
