Rails.application.routes.draw do

  devise_for :users, controllers: { 
    registrations: 'registrations', 
    confirmations: 'confirmations' 
    }

  root 'static_pages#index'

  resources :users do
    resources :pups
    resources :jobs, only: [:index]
    resources :availabilities, only: [:index]
    resources :requests, only: [:index, :edit, :destroy]
  end

  resources :jobs 

  resources :availabilities
  resources :requests, except: [:edit, :destroy]

end
