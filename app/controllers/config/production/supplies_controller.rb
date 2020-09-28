class Config::Production::SuppliesController < ApplicationController
  before_action :set_supply, only: %i[show edit update destroy]
    
  add_breadcrumb "Produccion", :config_production_root_path
  add_breadcrumb "Insumos", :config_production_supplies_path

  def index
  	@supplies = Supply.paginate(page: params[:page], per_page: 16)
    search if params[:q].present?
  end

  def new
    add_breadcrumb "Nuevo"
    @supply = Supply.new
    @treatment = Treatment.new
  end

  def edit
    add_breadcrumb "Editar"
  end

  def show
    add_breadcrumb "Detalle del Insumo"   
  end

  def create
    binding.pry
  	@supply = Supply.new(supply_params)
    if @supply.save
      respond_to do |format|
        format.html
        format.js
        format.json
      end
    else
      render :new
    end
  end

   def update
    if @supply.update(supply_params)
      flash[:notice] = "Insumo #{ @supply.name } actualizado correctamente"
      redirect_to config_production_supplies_url
    else
      render :edit
    end
  end

  def destroy
    @supply.destroy
  end

	private

  def search
    q = Regexp.escape(params[:q])
    
    @supplies = @supplies.where("name ~* ?", q)
  end

	def supply_params
    params.require(:supply).permit(:name, :currency, :iva, :ieps, :code, :category_id,
      presentation_supplies_attributes: [:id, :supply_id, :presentation_id, :_destroy],
      active_ingredient_supplies_attributes: [:id, :supply_id, :active_ingredient_id, :_destroy])   
  end

  def treatment_params
    params.require(:treatment).permit(:treatable_id, :treatable_type, 
      treatment_supplies_attributes: [:id, :supply_id, :treatment_id, :recommended_dose, :_destroy])
  end

  def set_supply
    # id = params[:id].present? ? params[:id] : params[:crop_id]
    @supply = Supply.find(params[:id])
  end
end
