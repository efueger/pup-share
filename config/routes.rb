Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' }
  
  root 'jobs#index'
  
  resources :jobs do
    match :walk_request,         via: [:put, :patch]
    match :approve_walk_request, via: [:get]
    match :deny_walk_request,    via: [:get]
  end

end
