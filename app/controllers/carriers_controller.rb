class CarriersController < ApplicationController
	before_action :set_object, only: %i[edit update destroy]
	
	def index
    @carriers = Carrier.all
  end

	def new
		@carrier = Carrier.new
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
    if @tax.update(tax_params)
      flash[:notice] = "#{@tax.name} Actualizado"
      redirect_to taxes_url
    else
      render :edit
    end
  end

  def destroy
    @tax.destroy
  end
	
  private

	def carrier_params
    params.require(:carrier).permit(
      :name, :rfc, :phone, :country, :state, :address, :cp)
  end

  def set_object
    @tax = Tax.find(params[:id])
  end
end