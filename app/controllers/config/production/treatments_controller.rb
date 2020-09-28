class Config::Production::TreatmentsController < ApplicationController
  before_action :find_treatment, only: %i[show edit update destroy]
  add_breadcrumb "Production", :config_production_root_path
  add_breadcrumb "Tratamientos", :config_production_treatments_path

  def index
    @index_facade = Treatments::IndexFacade.new(params)
  end

  def new
    add_breadcrumb "Nuevo"
    @treatment = Treatment.new
  end

  def show
    add_breadcrumb "Detalle del Tratamiento"
  end

  def create
    binding.pry
    @treatment = Treatment.new
    @treatment.treatable_id = treatment_params[:treatable_id]
    @treatment.treatable_type = treatment_params[:treatable_type]
    if @treatment.save
      treatment_params[:treatment_supplies_attributes].values.each do |treatment_supply|
        @supply = @treatment.treatment_supplies.new
        @supply.supply_id = treatment_supply[:supply_id]
        @supply.foliar_quantity = treatment_supply[:foliar_quantity]
        @supply.foliar_unit = treatment_supply[:foliar_unit]
        @supply.irrigation_quantity = treatment_supply[:irrigation_quantity]
        @supply.irrigation_unit = treatment_supply[:irrigation_unit]
        @supply.save
      end
      flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Tratamiento creado correctamente"
      redirect_to config_production_treatment_url(@treatment)
    else
      render :new
    end
  end

  def edit
    add_breadcrumb "Editar"
  end

  def update
    if @treatment.update(treatment_params)
      flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Tratamiento actualizado correctamente"
      redirect_to config_production_treatment_url(@treatment)
    else
      render :edit
    end
  end

  def destroy
    @treatment.destroy
  end

  private

  def treatment_params
    params.require(:treatment).permit(:treatable_id, :treatable_type, 
      treatment_supplies_attributes: [:id, :treatment_id, :supply_id, :_destroy, :foliar_quantity, :foliar_unit,
      :irrigation_quantity, :irrigation_unit])
  end 

  def find_treatment
    @treatment = Treatment.find(params[:id])
  end
end