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
    resources :client_brands
  end

  namespace :directories do
    resources :carriers
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
  resources :carriers do
    get '/get_drivers', to: 'carriers#get_drivers'
    get '/get_units', to: 'carriers#get_units'
    get '/get_boxes', to: 'carriers#get_boxes'
  end

  resources :shipments
  resources :companies
  resources :crops
  resources :sizes
  resources :qualities
  resources :colors
  resources :packages
	
	devise_for :users
  root to: "dashboard#index"
end
