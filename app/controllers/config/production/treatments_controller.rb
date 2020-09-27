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
    @treatment = Treatment.new(treatment_params)
    if @treatment.save
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
      treatment_supplies_attributes: [:id, :treatment_id, :supply_id, :_destroy, recommended_dose: {}])
  end 

  def find_treatment
    @treatment = Treatment.find(params[:id])
  end
end