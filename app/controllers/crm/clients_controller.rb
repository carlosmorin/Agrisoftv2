module Crm
  class ClientsController < ApplicationController
  	before_action :set_object, only: %i[show edit update destroy get_delivery_address get_contacts]
    before_action :set_catalogs, only: %i[edit update]

    add_breadcrumb "CRM", :crm_root_path
    add_breadcrumb "Clientes", :crm_clients_path

    def index
    	@clients = Client.paginate(page: params[:page], per_page: 16)
      search if params[:q].present?
    end

    def new
      add_breadcrumb "Nuevo"
    	@client = Client.new
      @client.fiscals.new.addresses.new
    end

    def create
    	@client = Client.new(client_params)
      if @client.save
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Cliente creado correctamente"
        redirect_to crm_client_url(@client, tab: :general) 
      else
        add_breadcrumb "Nuevo"
        render :new
      end
    end

    def edit
      add_breadcrumb "Editar"
      @client.fiscals.new.addresses.new if @client.fiscals.empty?
    end

    def show
      add_breadcrumb "Detalle de cliente"
    end

    def update
      if @client.update(client_params)
        flash[:notice] = "El cliente fue actualizado exitosamente"
        redirect_to crm_client_url(@client, tab: :general)
      else
        add_breadcrumb "Editar"
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
        :municipality_id, :cp, :address, :email, :conact_name, 
        fiscals_attributes: [:id, :bussiness_name, :rfc, :_destroy,
          addresses_attributes: [:id, :name, :street, :outdoor_number, :interior_number,
            :cp, :references, :neighborhood, :phone, :country_id, :state_id, 
            :fiscalcrosses, :locality, :fiscal, :crosses, :_destroy]]
      )
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