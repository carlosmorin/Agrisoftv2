class ClientsController < ApplicationController
	before_action :set_object, only: %i[show edit update destroy get_delivery_address]
  before_action :set_catalogs, only: %i[edit update]

  add_breadcrumb "Clientes", :clients_path

  def index
  	@clients = Client.paginate(page: params[:page], per_page: 16)
    search if params[:q].present?
  end

  def new
    add_breadcrumb "Nuevo"
  	@client = Client.new
  end

  def create
  	@client = Client.new(client_params)
    respond_to do |format|
      if @client.save
        format.html { redirect_to client_url(@client), 
          notice: 'El cliente fue registrado exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    add_breadcrumb "Editar"
  end

  def show
    add_breadcrumb "Detalle"
  end

  def update
    if @client.update(client_params)
      flash[:notice] = "El cliente fue actualizado exitosamente"
      redirect_to client_url(@client)
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
    binding.pry
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
