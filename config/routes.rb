Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' }
  
  root 'jobs#index'
  
  resources :jobs do
    match :walk_request, via: [:put, :patch]
    # get :approve_request # must use get because no form allowed/available in email
    # get :deny_request
  end

end
