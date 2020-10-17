class Config::Production::TreatmentsController < ApplicationController
  before_action :find_treatment, only: %i[show edit update destroy]
  before_action :find_objects, only: %i[new edit show]
  add_breadcrumb "Production", :config_production_root_path
  # add_breadcrumb "Tratamientos", :config_production_treatments_path

  def index
    @index_facade = Treatments::IndexFacade.new(params)
  end

  def new
    add_custom_breadcrumb
    add_breadcrumb "Nuevo"
    # binding.pry
    @desease = Desease.find(params[:desease_id]) if params[:desease_id].present?
    @pest = Pest.find(params[:pest_id]) if params[:pest_id].present?
    @is_supply_created ||= params[:create] || false
    # @show_destroy ||= true
    @treatment = Treatment.new
  end

  def show
    # binding.pry
    add_custom_breadcrumb
    add_breadcrumb "Detalle del Tratamiento"
  end

  def create
    @treatment = Treatment.new(crop_id: treatment_params[:crop_id])
    @treatment.treatable_id = treatment_params[:treatable_id]
    @treatment.treatable_type = treatment_params[:treatable_type]
    @treatment.application_instructions = treatment_params[:application_instructions]
    # binding.pry
    if @treatment.save
      # binding.pry
      if !!treatment_params[:treatment_supplies_attributes] 
        # # binding.pry
        treatment_params[:treatment_supplies_attributes].values.each do |treatment_supply|
          # # binding.pry
          @supply = @treatment.treatment_supplies.new
          @supply.supply_id = treatment_supply[:supply_id]
          # @supply.crop_id = treatment_supply[:crop_id]
          @supply.foliar_quantity = treatment_supply[:foliar_quantity]
          @supply.foliar_unit = treatment_supply[:foliar_unit]
          @supply.irrigation_quantity = treatment_supply[:irrigation_quantity]
          @supply.irrigation_unit = treatment_supply[:irrigation_unit]
          # # binding.pry
          @supply.save
          # binding.pry
        end
      end
      if !!treatment_params[:treatment_suppliess] 
        # # binding.pry
        @supply = @treatment.treatment_supplies.new
        @supply.supply_id = treatment_params[:supply_id]
        # @supply.crop_id = treatment_params[:treatment_suppliess][:crop_id]
        @supply.foliar_quantity = treatment_params[:treatment_suppliess][:foliar_quantity]
        @supply.foliar_unit = treatment_params[:treatment_suppliess][:foliar_unit]
        @supply.irrigation_quantity = treatment_params[:treatment_suppliess][:irrigation_quantity]
        @supply.irrigation_unit = treatment_params[:treatment_suppliess][:irrigation_unit]
        # # binding.pry
        @supply.save
        # binding.pry
        return redirect_to config_production_supply_url(treatment_params[:supply_id], tab: :treatments)
      end
      # binding.pry
      flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Tratamiento creado correctamente"
      return redirect_to config_production_desease_path(params[:desease_id], tab: :treatments) if params[:desease_id].present?
      return redirect_to config_production_pest_path(params[:pest_id], tab: :treatments) if params[:pest_id].present?
      redirect_to config_production_treatment_url(@treatment, tag: :general)
    else
      # binding.pry
      return redirect_to new_config_production_desease_treatment_path(desease_id: params[:desease_id]) if params[:desease_id].present?
      render :new
    end
  end

  def edit
    add_custom_breadcrumb
    add_breadcrumb "Editar"
    @is_edit = true
  end

  def update
    # WORK ON THIS METHOD NEXT 
    # binding.pry
    param_name = params[:supply_id].present? ? :supply_id : params[:desease_id].present? ? :desease_id : :pest_id
    custom_param = if params[:supply_id].present?
                      params[:supply_id]
                    elsif params[:desease_id].present?
                      params[:desease_id]
                    else
                      params[:pest_id]
                    end
    if @treatment.update(treatment_params)
      flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Tratamiento actualizado correctamente"
      redirect_to config_production_treatment_url(@treatment, tab: :general, "#{param_name}": custom_param)
    else
      render :edit
    end
  end

  def destroy
    # binding.pry
    if params[:desease_id].present?
      @desease = Desease.find(params[:desease_id])
      @desease.treatments.where(id: params[:id]).each { |treatment| treatment.destroy }
    end

    if params[:pest_id].present?
      @pest = Pest.find(params[:pest_id])
      @pest.treatments.where(id: params[:id]).each { |treatment| treatment.destroy }
    end

    if params[:supply_id].present?
      # @desease = Desease.find(params[:desease_id])
      # @desease.treatments.where(id: params[:id]).first.destroy
    end
  end

  private

  def treatment_params
    params.require(:treatment).permit(
      :treatable_id, 
      :treatable_type, 
      :application_instructions, 
      :crop_id, 
      :supply_id,
      treatment_suppliess: [
        :id, 
        :treatment_id, 
        :supply_id, 
        :_destroy, 
        :foliar_quantity, 
        :foliar_unit,
        :irrigation_quantity, 
        :irrigation_unit
      ],
      treatment_supplies_attributes: [
        :id,
        :supply_id, 
        :foliar_quantity, 
        :foliar_unit, 
        :irrigation_quantity, 
        :irrigation_unit,
        :_destroy
      ]
    )
  end 

  def find_treatment
    @treatment = Treatment.find(params[:id])
    @treatment.treatment_supplies.each do |treatment_supply|
      treatment_supply.destroy unless Supply.all.ids.include?(treatment_supply.supply_id)
    end
    # binding.pry
  end

  def find_objects
    @supply = Supply.find(params[:supply_id]) if params[:supply_id]
    @desease = Desease.find(params[:desease_id]) if params[:desease_id]
    @pest = Pest.find(params[:pest_id]) if params[:pest_id]
  end

  def add_custom_breadcrumb
    add_breadcrumb "Insumo", config_production_supply_url(@supply, tab: :treatments) if @supply.present?
    add_breadcrumb "Enfermedad", config_production_desease_url(@desease, tab: :treatments) if @desease.present?
    add_breadcrumb "Plaga", config_production_pest_url(@pest, tab: :treatments) if @pest.present?
  end
end