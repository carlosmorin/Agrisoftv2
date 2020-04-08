class CarriersController < ApplicationController
	before_action :set_object, only: %i[show edit update destroy]
  add_breadcrumb "Transportistas", :carriers_path
	
	def index
    @carriers = Carrier.paginate(page: params[:page], per_page: 18)
    search if params[:q].present?
  end

	def new
    add_breadcrumb "Nuevo"
    @carrier = Carrier.new
	end

  def edit
    add_breadcrumb "Editar"
  end

  def show
    add_breadcrumb "Detalle"
  end

  def create
    @carrier = Carrier.new(carrier_params)
    respond_to do |format|
      if @carrier.save
        format.html { redirect_to carriers_url, notice: 'Transportista creado' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if @carrier.update(carrier_params)
      flash[:notice] = "#{@carrier.name} Actualizado"
      redirect_to carriers_url
    else
      render :edit
    end
  end

  def destroy
    @carrier.destroy
  end
	
  private

  def search
    q = Regexp.escape(params[:q])
    
    @carriers = @carriers.where("concat(name, ' ', rfc, ' ', phone) ~* ?", q)
  end

	def carrier_params
    params.require(:carrier).permit(
      :name, :rfc, :phone, :country, :state, :address, :cp, :municipality)
  end

  def set_object
    @carrier = Carrier.find(params[:id])
  end
end