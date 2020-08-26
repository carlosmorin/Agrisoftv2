Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
  	root to: "main#index"
  	resources :users
	end

  namespace :reports do
    resources :lumps, only: [:index]
    resources :products, only: [:index]
  end

  namespace :config do
    resources :taxes
    resources :drivers
    resources :units
    resources :boxes
    resources :delivery_addresses
    resources :client_brands
    resources :products
    resources :currencies
    namespace :production do 
      root to: 'main#index'
      resources :ranches do
        resources :areas
        resources :perforations
      end
      resources :areas
      resources :activities
      resources :perforations
      resources :stages
      resources :sub_stages
    end
  end

  namespace :logistic do
    root to: "main#index"
    resources :freights
    resources :carriers do
      resources :drivers
      resources :units
      resources :freights
      resources :boxes
      resources :contacts, except: [:index]
      resources :bank_accounts, except: [:index]
    end
    resources :contacts, except: [:index]
    resources :bank_accounts, except: [:index]
    resources :units
    resources :drivers
    resources :boxes
    namespace :config do
      root to: "main#index"
      resources :box_types
      resources :unit_brands
    end
  end
  
  namespace :commercial do
    root to: "main#index" #Comercial dashboard
    resources :providers do
      resources :addresses
    end
    namespace :config do
      root to: "main#index"
      resources :provider_categories do
        get '/get_subcategories', to: 'provider_categories#get_subcategories'
      end
    end
  end

  namespace :crm do
    root to: "main#index" #CRM dashboard
    resources :clients do
      resources :contacts, except: [:index]
      resources :delivery_addresses, except: [:index]
      resources :contracts, only: [:new, :edit, :show]
      resources :bank_accounts, except: [:index]

      get '/get_delivery_address', to: 'clients#get_delivery_address'
      get '/get_contacts', to: 'clients#get_contacts'
    end
    resources :sales
    resources :contracts, only: [:create, :update]
    resources :bank_accounts, except: [:index]

    resources :delivery_addresses, except: [:index]
    resources :contacts, except: [:index]
    resources :quotes do
      get '/print', to: 'quotes#print'
      patch '/update_status', to: 'quotes#update_status'
      collection do
        get :consolidate
      end
    end
    resources :sales_orders
    
    namespace :config do
      root to: "main#index"
      resources :expenses
    end
  end
  
  namespace :directories do
    resources :carriers do
      resources :drivers
    end
    resources :clients
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
  
  resources :carriers do
    get '/get_drivers', to: 'carriers#get_drivers'
    get '/get_units', to: 'carriers#get_units'
    get '/get_boxes', to: 'carriers#get_boxes'
  end

  resources :shipments do
    get '/consolidate', to: 'shipments#consolidate'
    get '/print', to: 'shipments#print'
    get '/print_responsive', to: 'shipments#print_responsive'
  end

  resources :companies
  resources :crops do
    get '/get_colors', to: 'crops#get_colors'
    get '/get_qualities', to: 'crops#get_qualities'
    get '/get_sizes', to: 'crops#get_sizes'
    get '/get_packages', to: 'crops#get_packages'
  end
  resources :sizes
  resources :qualities
  resources :colors
  resources :packages
  resources :profile, except: [:new] do
    get '/avatar', to: 'profile#avatar'
    get '/change_password', to: 'profile#change_password'
  end
	
	devise_for :users
  root to: "dashboard#index"
end
