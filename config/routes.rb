# rails s -b 0.0.0.0 runs the local server when using Nitrous.io

Rails.application.routes.draw do

  devise_for :users

  root 'jobs#index'
  resources :jobs do
    match :walk_request, via: [:put, :patch]
    # get :approve_request # must use get because no form allowed/available in email
    # get :deny_request
  end

end
