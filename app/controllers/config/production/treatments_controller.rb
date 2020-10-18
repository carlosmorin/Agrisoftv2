class Config::Production::TreatmentsController < ApplicationController
  before_action :find_treatment, only: %i[show edit update destroy]
  before_action :find_objects, only: %i[new edit show]
  add_breadcrumb "Production", :config_production_root_path  

  def index
    @index_facade = Treatments::IndexFacade.new(params)
  end

  def new
    add_custom_breadcrumb
    add_breadcrumb "Nuevo"    
    @desease = Desease.find(params[:desease_id]) if params[:desease_id].present?
    @pest = Pest.find(params[:pest_id]) if params[:pest_id].present?
    @is_supply_created ||= params[:create] || false    
    @treatment = Treatment.new
  end

  def show    
    add_custom_breadcrumb
    add_breadcrumb "Detalle del Tratamiento"
  end

  def create
    @treatment = Treatment.new(treatment_params.except(:supply_id, :treatment_suppliess))
    if @treatment.save
      if !!treatment_params[:treatment_suppliess]       
        add_extra_treatment_supply     
        return redirect_to config_production_supply_url(treatment_params[:supply_id], tab: :treatments)
      end  
      flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Tratamiento creado correctamente"
      return redirect_to config_production_desease_path(params[:desease_id], tab: :treatments) if params[:desease_id].present?
      return redirect_to config_production_pest_path(params[:pest_id], tab: :treatments) if params[:pest_id].present?
      return redirect_to config_production_treatment_url(@treatment, tag: :general)
    else    
      redirect_to_current_resource
    end
  end

  def edit
    add_custom_breadcrumb
    add_breadcrumb "Editar"
    @is_edit = true
  end

  def update    
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
    if params[:desease_id].present?
      @desease = Desease.find(params[:desease_id])
      @desease.treatments.where(id: params[:id]).each { |treatment| treatment.destroy }
    end

    if params[:pest_id].present?
      @pest = Pest.find(params[:pest_id])
      @pest.treatments.where(id: params[:id]).each { |treatment| treatment.destroy }
    end

    if params[:supply_id].present?
      @treatment.destroy         
    end
  end

  def treatment_exist
    # binding.pry
    @treatment = Treatment.find_by(treatable_id: params[:treatable_id], treatable_type: params[:treatable_type], crop_id: params[:crop_id])
    errors = [""]
    errors = ["Este tratamiento ya existe"] unless @treatment.nil?
    render json: errors
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

  def set_supply_fields(treatment_supply)
    @supply.foliar_quantity = treatment_supply[:foliar_quantity]
    @supply.foliar_unit = treatment_supply[:foliar_unit]
    @supply.irrigation_quantity = treatment_supply[:irrigation_quantity]
    @supply.irrigation_unit = treatment_supply[:irrigation_unit]   
  end

  def redirect_to_current_resource
    return redirect_to new_config_production_desease_treatment_path(desease_id: params[:desease_id]) if params[:desease_id].present?
    return redirect_to new_config_production_pest_treatment_path(pest_id: params[:pest_id]) if params[:pest_id].present?
    return redirect_to new_config_production_supply_treatment_path(supply_id: params[:supply_id]) if params[:supply_id].present?
  end

  def add_extra_treatment_supply     
    @supply = @treatment.treatment_supplies.new
    @supply.supply_id = treatment_params[:supply_id]  
    set_supply_fields(treatment_params[:treatment_suppliess])                
    @supply.save        
  end
end