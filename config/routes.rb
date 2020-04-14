Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
  	root to: "main#index"
  	resources :users
	end

  namespace :config do
    resources :unit_brands
    resources :box_types
    resources :drivers
    resources :taxes
    resources :units
    resources :boxes
    resources :delivery_addresses
  end

  namespace :addresses do
    resources :countries
    resources :states
    resources :municipalities
    ##End points to addres
    get '/addresses/states', to: 'addresses#states'
    get '/addresses/municipalities', to: 'addresses#municipalities'
    get '/addresses/locations', to: 'addresses#locations'
  end
  
  resources :clients
  resources :carriers
  resources :shipments
  resources :companies
	
	devise_for :users
  root to: "dashboard#index"
end
