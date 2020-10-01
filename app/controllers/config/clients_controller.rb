module Config
	class ClientsController < ApplicationController
		add_breadcrumb "Configuración"
		
		def index
			add_breadcrumb "Clientes"
			@clients = Client.all

			filter_by_query if params[:query].present?
		end

		def show
			@client = Client.find(params[:id])
			@client_config = @client.settings.present? ? @client.settings : ClientConfig.new(client_id: @client.id)
		end

    def create
    	@client_config = ClientConfig.new(client_config_params)
      if @client_config.save
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-16'></i>  Configuración guardada correctamente"
        redirect_to config_client_url(@client_config.client_id, tab: :sales) 
      end
    end

    def update
    	@client_config = Client.find(params[:id]).settings
      if @client_config.update(client_config_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-16'></i>  Configuración guardada correctamente"
        redirect_to config_client_url(@client_config.client_id, tab: :sales) 
      end
    end

    def client_config_params
    	params.require(:client_config).permit(:id, :currency_id, :pay_freight, :client_type, :client_id)
    end

    private

    def filter_by_query
	    query = Regexp.escape(params[:query])
	    
	    @clients = @clients.where("name ~* ?", query)
    end

	end
end