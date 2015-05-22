# rails s -b 0.0.0.0 runs the local server when using Nitrous.io

Rails.application.routes.draw do
  
  devise_for :users
  
  root 'jobs#index'
  
  resources :pups
  resources :jobs

  get 'help', :to => 'static_pages#help'

end
