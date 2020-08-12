class FreightsController < ApplicationController
	before_action :set_object, only: %i[show edit update destroy]
  before_action :set_catalogs, only: %i[edit update]

  add_breadcrumb "Embarques", :clients_path

  def index
  	@freights = Freight.paginate(page: params[:page], per_page: 25)
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

  def freight_params
    params.require(:freight).permit(
      :carrier_id, :driver_id, :unit_id, :box_id, :user_id,
          shipments_attributes: [:id, :company_id, :client_id,
            :delivery_address_id, :user_id, :status, :comments, :_destroy, :pay_freight,
          shipments_products_attributes: [:id, :price, :quantity, :shipment_id,
            :product_id, :_destroy]]
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
