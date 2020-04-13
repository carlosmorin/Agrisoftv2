module Config
	class DeliveryAddressesController < ApplicationController
    before_action :set_object, only: %i[edit update destroy show]
    before_action :set_catalogs, only: %i[edit update]

  	add_breadcrumb "Config"
    add_breadcrumb "Direcciónes de entrega", :config_delivery_addresses_path

  	def index
  		@delivery_addresses = DeliveryAddress.all
  	end

		def new
      add_breadcrumb "Nuevo"
			@address = DeliveryAddress.new
		end

    def edit
      add_breadcrumb "Editar"
    end

    def show
      add_breadcrumb "Detalle"
    end

    def create
      @address = DeliveryAddress.new(address_params)
      if @address.save
        flash[:notice] = 'Dirección de entrega creada'
        redirect_to config_delivery_addresses_path
      else
        render :new
      end
    end

    def update
      if @address.update(address_params)
        flash[:notice] = "Dirección actualizada"
        redirect_to config_delivery_addresses_path
      else
        render :edit
      end
    end

    def destroy
      @carrier.destroy
    end

    private

    def address_params
      params.require(:delivery_address).permit(
        :client_id, :country_id, :state_id, :municipality_id, :address, 
        :comments, :phone, :name, :contact_name, :email)
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