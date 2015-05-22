# rails s -b 0.0.0.0 runs the local server when using Nitrous.io

Rails.application.routes.draw do
  
  devise_for :users
  
  resources :pups
  resources :jobs

  root 'static_pages#index'
  get 'help', :to => 'static_pages#help'

end
