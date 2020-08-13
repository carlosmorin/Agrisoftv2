module Crm
	class DeliveryAddressesController < ApplicationController
    include DeliveryAddressesBreadcrumbs

    before_action :set_object, only: %i[edit update destroy show]
    before_action :set_client, :set_breadcrumb, only: %i[new edit]

  	def index
  		@delivery_addresses = DeliveryAddress.paginate(page: params[:page], per_page: 16)
      search if params[:q].present?
      search_by_client if params[:c].present?
  	end

		def new
			@address = DeliveryAddress.new(client_id: params[:client_id])
		end

    def edit
    end

    def show
      add_breadcrumb "Detalle"
    end

    def create
      @address = DeliveryAddress.new(address_params)
      if @address.save
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Dirección creada correctamente"
        redirect_to crm_client_path(@address.client, tab: :addresses)
      else
        set_client
        set_breadcrumb
        render :new
      end
    end

    def update
      if @address.update(address_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Dirección actualizada correctamente"
        redirect_to crm_client_path(@address.client, tab: :addresses)
      else
        set_client
        set_breadcrumb
        render :edit
      end
    end

    def destroy
      @address.destroy
    end

    private
    
    def search
      q = Regexp.escape(params[:q])
      
      @delivery_addresses = @delivery_addresses.where("concat(name, ' ', phone, ' ', contact_name) ~* ?", q)
    end

    def search_by_client
      client_id = Regexp.escape(params[:c])
      
      @delivery_addresses = @delivery_addresses.where(client_id: client_id)
    end

    def address_params
      params.require(:delivery_address).permit(
        :client_id, :country_id, :state_id, :municipality_id, :address, 
        :comments, :phone, :name, :contact_name, :email, :external)
    end

    def set_object
      @address = DeliveryAddress.find(params[:id])
    end

    def set_catalogs
      country = Country.find(@address.country_id)
      state = State.find(@address.state_id)

      @states = country.states
      @municipalities = state.municipalities
    end
  end
end