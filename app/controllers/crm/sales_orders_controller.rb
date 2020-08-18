module Crm
  class SalesOrdersController < ApplicationController
  	before_action :set_object, only: %i[show edit update]
    before_action :set_catalogs, only: %i[edit update]

    add_breadcrumb "CRM", :crm_root_path
    add_breadcrumb "Ordenes de venta", :crm_sales_orders_path

    def index
    	@sales_orders = Shipment.order_sale.paginate(page: params[:page], per_page: 16)
      search if params[:q].present?
    end

    def edit
      add_breadcrumb "Editar"
    end

    def show
      add_breadcrumb "Detalle de orden de venta"
    end

    def update
      if @sales_order.update(client_params)
        flash[:notice] = "Orden de venta actualizada exitosamente"
        redirect_to crm_sales_order_url(@sales_order)
      else
        render :edit
      end
    end

    def destroy
      @client.destroy
    end

    def get_delivery_address
      ## da = delivery_address
      da = @client.delivery_addresses
      render json: da
    end
    
    def get_contacts
      contacts = @client.contacts
      render json: contacts
    end
  	
    private

    def search
      q = Regexp.escape(params[:q])
      
      @clients = @clients.where("concat(name, ' ', rfc, ' ', phone) ~* ?", q)
    end

  	def client_params
      params.require(:client).permit(:name, :rfc, :code, :phone, :country_id, :state_id, 
        :municipality_id, :cp, :address, :email, :conact_name)
    end

    def set_object
      id = params[:id].present? ? params[:id] : params[:client_id] 
      @client = Client.find(id)
    end

    def set_catalogs
      country = Country.find(@client.country_id)
      state = State.find(@client.state_id)

      @states = country.states
      @municipalities = state.municipalities
    end
  end
end