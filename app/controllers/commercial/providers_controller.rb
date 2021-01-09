# frozen_string_literal: true

module Commercial
  class ProvidersController < ApplicationController
    before_action :set_object, only: %i[show edit update destroy update_status supplies]

    add_breadcrumb 'Comercial', :commercial_root_path
    add_breadcrumb 'Proveedores', :commercial_providers_path

    def index
      @providers = Provider.all.paginate(page: params[:page], per_page: 16)

      search if params[:query].present?
      filter_providers_by_category if params[:category].present?
      filter_providers_by_subcategory if params[:provider_subcategory_id].present?
    end

    def new
      add_breadcrumb 'Nuevo proveedor'
      @provider = Provider.new
    end

    def edit
      add_breadcrumb 'Editar'
    end

    def show
      add_breadcrumb 'Gestionar proveedor'
    end

    def supplies
      @supplies = Supply.where.not(id: @provider.providers_supplies.pluck(:supply_id))
      @supplies_collection = @provider.providers_supplies

      filter_by_query if params[:query].present?
      filter_by_category if params[:category].present?
      xls_export if params[:format].present?
    end

    def create
      @provider = Provider.new(provider_params)

      if @provider.save
        msg = "Proveedor creado correctamente <i class='fas fa-check-circle ml-2'></i>"
        flash[:notice] = msg
        redirect_to commercial_provider_path(@provider)
      else
        add_breadcrumb 'Nuevo proveedor'
        render :new
      end
    end

    def update
      if @provider.update(provider_params)
        msg = "Proveedor actualizado correctamente <i class='fas fa-check-circle ml-2'></i>"
        flash[:notice] = msg
        redirect_to commercial_provider_path(@provider)
      else
        render :edit
      end
    end

    def add_supplies
      return if params[:supplies].empty?
      params[:supplies].each do |supply|
        ProvidersSupply.new(provider_id: params[:provider_id], supply_id: supply).save!
      end
    end 

    def destroy
      @provider.destroy
    end

    def update_status
      status = params[:status]
      @provider.update(status: params[:status])
    end

    def delete_supply
      ps = ProvidersSupply.find(params[:ps])
      ps.destroy!
    end

    private

    def search
      query = Regexp.escape(params[:query])

      @providers = @providers.where("CONCAT(name, '', code) ~* ?", query)
    end

    def filter_providers_by_category
      category = params[:category]
      @providers = @providers.where(provider_category_id: category)
    end

    def filter_providers_by_subcategory
      subcategory = params[:provider_subcategory_id]

      @providers = @providers.where(subcategory_id: subcategory)
    end

  	def provider_params
      params.require(:provider).permit(:id, :code, :name, :provider_type, 
        :credit_limit, :credit_limit_days, :delivery_days, :currency_id, 
        :provider_category_id, :subcategory_id, :delivery_type_id, :fiscal,
        :logo, 
        contacts_attributes: [
          :id, :name, :last_name, :email, :phone, :mobile_phone, :position, 
          :alias, :contactable_type, :contactable_id, :avatar, :main_contact, 
          :_destroy
        ],
        addresses_attributes: addresses_attributes,
        bank_accounts_attributes: [
          :id, :bank_id, :currency_id, :name, :titular, :bank_key, 
          :account_number, :card_number, :branch, :accountable_type, 
          :accountable_id, :_destroy
        ],
        fiscals_attributes: [
          :id, :bussiness_name, :rfc, :cfdi_usage, :payment_mean, 
          :payment_method, :_destroy,
          addresses_attributes: addresses_attributes
        ]
      )
    end

    def set_object
      id = params[:id].present? ? params[:id] : params[:provider_id]
      @provider = Provider.find(id)
    end

    def addresses_attributes
      [ :id, :name, :street, :outdoor_number, :interior_number, :cp,
        :references, :neighborhood, :phone, :country_id, :state_id, :comments, 
        :status, :addressable_type, :addressable_id, :locality, :crosses, 
        :_destroy ]
    end

    def filter_by_query
      query = params[:query]
      @supplies_collection = @supplies_collection.joins(:supply).where("concat(supplies.name, ' ', supplies.code) ~* ?", query)
    end

    def filter_by_category
      category = params[:category]

      @supplies_collection = @supplies_collection.joins(:supply).where("supplies.category_id": category)
    end

    def xls_export
      render xlsx: 'Catalogo de productos', template: 'commercial/providers/products.xlsx.axlsx'
    end
  end
end
