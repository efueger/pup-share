Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' }
  
  root 'jobs#index'
  
  resources :jobs do
    match :walk_request,         via: [:put, :patch]
    match :approve_walk_request, via: [:get]          # must use get because no form allowed/available in email
    match :deny_walk_request,    via: [:get]          # must use get because no form allowed/available in email
  end

end
