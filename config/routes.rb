Rails.application.routes.draw do



  devise_for :users, controllers: { 
    registrations: 'registrations', 
    confirmations: 'confirmations' 
    }

  resources :users do
    resources :pups
  end

  root 'jobs#index'

  resources :jobs do
    member do
      match :walk_request,         via: [:put, :patch]
      match :approve_walk_request, via: [:get]
      match :deny_walk_request,    via: [:get]
      match :cancel_walk,          via: [:get] 
    end
  end
end
