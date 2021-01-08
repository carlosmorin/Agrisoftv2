# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    root to: 'main#index'
    resources :users
  end

  namespace :reports do
    resources :lumps, only: [:index]
    resources :products, only: [:index]
  end

  scope module: 'config/production', path: 'categories/:id' do
    get '/get_supplies_codes', to: 'categories#get_supplies_codes'
  end

  scope module: 'config/production', path: 'crops' do
    get '/get_crops', to: 'crops#get_crops'
    get '/:id/get_pests', to: 'crops#get_pests'
    get '/:id/get_deseases', to: 'crops#get_deseases'
  end

  scope module: 'config/production', path: 'treatments' do
    get '/treatment_exist', to: 'treatments#treatment_exist'
  end

  namespace :config do
    resources :taxes
    resources :drivers
    resources :units
    resources :boxes
    resources :delivery_addresses
    resources :client_brands
    resources :currencies
    namespace :production do
      root to: 'main#index'
      resources :categories
      resources :treatments
      resources :active_ingredients
      resources :presentations
      resources :supplies do
        resources :treatments
        resources :presentations, only: %i[update edit show]
        resources :active_ingredients, only: %i[update edit show]
      end
      resources :ranches do
        resources :areas
        resources :perforations
      end
      resources :production_units, except: %i[show]
      resources :weight_units, only: %i[index create destroy]
      resources :irrigation_types, only: %i[index create destroy]
      resources :areas
      resources :activities
      resources :perforations
      resources :stages
      resources :sub_stages
      resources :crops do
        resources :deseases
        resources :pests
        member do
          get '/get_colors', to: 'crops#get_colors'
          get '/get_qualities', to: 'crops#get_qualities'
          get '/get_sizes', to: 'crops#get_sizes'
          get '/get_packages', to: 'crops#get_packages'
        end
      end
      resources :products
      resources :sizes
      resources :qualities
      resources :colors
      resources :packages
      resources :hosts
      resources :damages
      resources :pests do
        resources :treatments
        resources :hosts
        resources :damages
        member do
          patch '/update_pictures', to: 'pests#update_pictures'
        end
      end
      resources :deseases do
        resources :treatments
        resources :hosts
        resources :damages
        member do
          patch '/update_pictures', to: 'deseases#update_pictures'
        end
      end
    end
    namespace :admin do
      resources :expense_concepts
    end
    resources :clients, except: [:edit]
  end

  namespace :logistic do
    root to: 'main#index'
    resources :freights
    resources :carriers do
      resources :drivers
      resources :units
      resources :freights
      resources :boxes
      resources :contacts, except: [:index]
      resources :bank_accounts, except: [:index]
    end
    resources :bank_accounts, except: [:index]
    resources :contacts, except: [:index]
    resources :units
    resources :drivers
    resources :boxes
    namespace :config do
      root to: 'main#index'
      resources :box_types
      resources :unit_brands
    end
  end

  namespace :commercial do
    root to: 'main#index' # Comercial dashboard
    resources :providers do
      patch :update_status
      resources :addresses
      get :supplies
      patch :add_supplies
    end
    namespace :config do
      root to: 'main#index'
      resources :delivery_types, except: [:show, :new]
      resources :provider_categories do
        get '/get_subcategories', to: 'provider_categories#get_subcategories'
      end
    end
  end

  namespace :credit do
    resources :payment_advances
  end

  namespace :billing do
    resources :pre_bills do
      patch :update_discounts
      patch :manual_stamp
      patch :cancel
    end
  end

  namespace :crm do
    root to: 'main#index' # CRM dashboard
    resources :report_prices, except: %i[index show]
    resources :products, only: %i[edit update]
    resources :expenses, except: %i[index show] do
      collection do
        get 'build_detail'
      end
    end
    resources :clients do
      collection do
        get 'delivery_addresses'
      end
      resources :contacts, except: [:index]
      resources :delivery_addresses, except: [:index]
      resources :contracts, only: %i[new edit show]
      resources :bank_accounts, except: [:index]
      resources :fiscals, except: [:index]

      get '/get_delivery_address', to: 'clients#get_delivery_address'
      get '/get_contacts', to: 'clients#get_contacts'
    end
    resources :sales do
      patch '/expenses', to: 'sales#update_expenses'
      patch '/products', to: 'sales#update_products'
      patch '/reports', to: 'sales#update_reports'
      patch '/cancel', to: 'sales#cancel'
      patch '/set_contract', to: 'sales#set_contract'
      patch '/update_currency', to: 'sales#update_currency'
      patch '/documents', to: 'sales#update_documents'
      get '/to_collect', to: 'sales#to_collect'
      get '/manage', to: 'sales#manage'
      get '/get_report_products', to: 'sales#get_report_products'
    end
    resources :contracts, only: %i[create update]
    resources :bank_accounts, except: [:index]

    resources :delivery_addresses, except: [:index] do
      collection do
        patch :update_prices
      end
    end
    resources :contacts, except: [:index]
    resources :fiscals, except: [:index]
    resources :quotes do
      get '/print', to: 'quotes#print'
      patch '/update_status', to: 'quotes#update_status'
      patch '/cancel', to: 'quotes#cancel'
      collection do
        get :consolidate
      end
    end
    resources :sales_orders do
      get '/print', to: 'sales_orders#print'
      patch '/cancel', to: 'sales_orders#cancel'
      get '/print_aditional_data', to: 'sales_orders#print_aditional_data'
    end

    namespace :config do
      root to: 'main#index'
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
    # #End points to addres
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
  resources :profile, except: [:new] do
    get '/avatar', to: 'profile#avatar'
    get '/change_password', to: 'profile#change_password'
  end

  devise_for :users
  root to: 'dashboard#index'
end
