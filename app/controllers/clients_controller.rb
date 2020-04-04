class ClientsController < ApplicationController
	before_action :set_object, only: %i[show edit update destroy]
  add_breadcrumb "Clientes", :clients_path

  def index
  	@clients = Client.all
  end

  def new
    add_breadcrumb "Nuevo cliente"
  	@client = Client.new
  end

  def create
  	@client = Client.new(client_params)
    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_url, notice: 'El cliente fue registrado exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

   def update
    if @client.update(client_params)
      flash[:notice] = "#{@client.name} Actualizado"
      redirect_to clients_url
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
  end

	private

	def client_params
    params.require(:client).permit(:name, :rfc, :phone, :country, :state, :cp, :address, :value)
  end

  def set_object
    @client = Client.find(params[:id])
  end
end
