class Config::Production::TreatmentsController < ApplicationController
  before_action :find_treatment, only: %i[show edit update destroy]
  before_action :find_supply, only: %i[new edit show]
  add_breadcrumb "Production", :config_production_root_path
  # add_breadcrumb "Tratamientos", :config_production_treatments_path

  def index
    @index_facade = Treatments::IndexFacade.new(params)
  end

  def new
    add_breadcrumb "Nuevo"
    # # binding.pry
    @is_supply_created ||= params[:create] || false
    @show_destroy ||= true
    @treatment = Treatment.new
  end

  def show
    add_breadcrumb "Insumo", config_production_supply_url(@supply, tab: :treatments)
    add_breadcrumb "Detalle del Tratamiento"
  end

  def create
    # # binding.pry
    # params[:treatment][:supply_id] = Supply.last.id
    # @treatment = Treatment.new(treatment_params)
    # if @treatment.save
    #   flash[:notice] = "Insumo #{ Supply.last.name } creado correctamente"
    #   redirect_to config_production_supplies_url
    # else
    # #   binding.pry
    #   render 'supplies/new'
    # end
    @treatment = Treatment.new(crop_id: treatment_params[:crop_id])
    @treatment.treatable_id = treatment_params[:treatable_id]
    @treatment.treatable_type = treatment_params[:treatable_type]
    @treatment.application_instructions = treatment_params[:application_instructions]
    # binding.pry
    if @treatment.save
      # binding.pry
      if !!treatment_params[:treatment_supplies_attributes] 
        # binding.pry
        treatment_params[:treatment_supplies_attributes].values.each do |treatment_supply|
          # binding.pry
          @supply = @treatment.treatment_supplies.new
          @supply.supply_id = treatment_supply[:supply_id]
          # @supply.crop_id = treatment_supply[:crop_id]
          @supply.foliar_quantity = treatment_supply[:foliar_quantity]
          @supply.foliar_unit = treatment_supply[:foliar_unit]
          @supply.irrigation_quantity = treatment_supply[:irrigation_quantity]
          @supply.irrigation_unit = treatment_supply[:irrigation_unit]
          # binding.pry
          @supply.save
          # binding.pry
        end
      end
      if !!treatment_params[:treatment_suppliess] 
        # binding.pry
        @supply = @treatment.treatment_supplies.new
        @supply.supply_id = treatment_params[:supply_id]
        # @supply.crop_id = treatment_params[:treatment_suppliess][:crop_id]
        @supply.foliar_quantity = treatment_params[:treatment_suppliess][:foliar_quantity]
        @supply.foliar_unit = treatment_params[:treatment_suppliess][:foliar_unit]
        @supply.irrigation_quantity = treatment_params[:treatment_suppliess][:irrigation_quantity]
        @supply.irrigation_unit = treatment_params[:treatment_suppliess][:irrigation_unit]
        # binding.pry
        @supply.save
        # binding.pry
        return redirect_to config_production_supply_url(treatment_params[:supply_id], tab: :treatments)
      end
      # binding.pry
      flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Tratamiento creado correctamente"
      redirect_to config_production_treatment_url(@treatment, tag: :general)
    else
      render :new
    end
  end

  def edit
    add_breadcrumb "Insumo", config_production_supply_url(@supply, tab: :treatments)
    add_breadcrumb "Editar"
    @is_edit = true
  end

  def update
    # WORK ON THIS METHOD NEXT 
    binding.pry
    if @treatment.update(treatment_params)
      flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Tratamiento actualizado correctamente"
      redirect_to config_production_treatment_url(@treatment, tab: :general, supply_id: params[:supply_id])
    else
      render :edit
    end
  end

  def destroy
    @treatment.destroy
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

  def find_supply
    @supply = Supply.find(params[:supply_id]) if params[:supply_id]
  end
end