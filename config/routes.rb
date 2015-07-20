Rails.application.routes.draw do

  devise_for :users, controllers: { 
    registrations: 'registrations', 
    confirmations: 'confirmations' 
    }

  root 'static_pages#index'
  get 'about', to: 'static_pages#about'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'privacy_policy', to: 'static_pages#privacy_policy'

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
