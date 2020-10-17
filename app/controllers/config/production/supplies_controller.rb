class Config::Production::SuppliesController < ApplicationController
  before_action :set_supply, only: %i[show edit update destroy]
    
  add_breadcrumb "Produccion", :config_production_root_path
  add_breadcrumb "Insumos", :config_production_supplies_path

  def index
    @supplies = Supply.paginate(page: params[:page], per_page: 16)
    # # binding.pry
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
    # # binding.pry
    add_breadcrumb "Detalle del Insumo"   
  end

  def create
    # # binding.pry
  	@supply = Supply.new(supply_params)
    if @supply.save
      flash[:notice] = "Insumo #{ @supply.name } actualizado correctamente"
      return redirect_to new_config_production_supply_treatment_url(@supply.id, create: true), create: true if params[:create_treatment]
      redirect_to config_production_supplies_url
    else
      render :new
    end
  end

  def update
    if @supply.update(supply_params)
      flash[:notice] = "Insumo #{ @supply.name } actualizado correctamente"
      return redirect_to new_config_production_supply_treatment_url(@supply.id, create: true), create: true if params[:create_treatment]
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
      presentation_supplies_attributes: [:id, :supply_id, :presentation_id, :price, :price_to_credit, :_destroy],
      active_ingredient_supplies_attributes: [:id, :supply_id, :active_ingredient_id, :percentage, :_destroy])   
  end

  def treatment_params
    params.require(:treatment).permit(:treatable_id, :treatable_type, :application_instructions,
      treatment_supplies_attributes: [:id, :treatment_id, :supply_id, :_destroy, :foliar_quantity, :foliar_unit,
      :irrigation_quantity, :irrigation_unit])
  end 

  def set_supply
    # id = params[:id].present? ? params[:id] : params[:crop_id]
    @supply = Supply.find(params[:id])
    if params[:tab] == "treatments"
      treatment_supplies = TreatmentSupply.where(supply_id: params[:id])
      @treatments = []
      # binding.pry
      treatment_supplies.each do |treatment_supply|
        treatable_type = treatment_supply.treatment.treatable_type
        id = treatment_supply.treatment.treatable_id
        name = treatable_type == "Desease" ? Desease.find(id).name : Pest.find(id).name
        # binding.pry
        hash = {
          id: treatment_supply.treatment.id,
          foliar_quantity: treatment_supply.foliar_quantity,
          foliar_unit: treatment_supply.foliar_unit,
          irrigation_quantity: treatment_supply.irrigation_quantity,
          irrigation_unit: treatment_supply.irrigation_unit,
          crop_name: Crop.find(treatment_supply.treatment.crop_id).name,
          treatable_type: name,
          treatable_type_name: treatable_type,
          supply_count: treatment_supply.treatment.supplies_count
        }
        @treatments.push(hash)
      end
      # # binding.pry
    end
  end
end
