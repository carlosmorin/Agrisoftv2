Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
  	root to: "main#index"
  	resources :users
	end

  namespace :config do
    resources :unit_brands
    resources :box_types
  end
  
  resources :taxes
  resources :clients
  resources :carriers
  resources :companies
  resources :vegetables
	
	devise_for :users
  root to: "dashboard#index"
end
