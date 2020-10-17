class Config::Production::PestsController < ApplicationController
  before_action :find_pest, only: %i[show edit destroy update]
  before_action :set_crop, only: %i[new update]
  before_action :set_params, only: %i[create]

  add_breadcrumb "Produccion", :config_production_root_path
  add_breadcrumb "Plagas", :config_production_pests_path

  def index
    @index_facade = Pests::IndexFacade.new(params)
  end

  def create
    if @pest.save
      @crop_pest = @pest.crops_pests.new(crop_id: params[:crop_id]) if params[:crop_id].present?
      @crop_pest.save unless @crop_pest.nil?
      flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Plaga creada correctamente"
      return redirect_to config_production_crop_path(params[:crop_id], tab: :pests) if params[:crop_id].present?
      return redirect_to config_production_pest_url(@pest, tab: :general)
    else
      return render :new unless params[:crop_id].present?
    end
    flash[:alert] = "#{PestDecorator.new(@pest).display_errors}"
    redirect_to new_config_production_crop_pest_path(params[:crop_id])
  end

  def new
    add_breadcrumb "Nuevo"
    @pest = Pest.new
    @pest.crops_pests.build
  end

  def edit
    add_breadcrumb "Editar"
  end

  def show
    add_breadcrumb "Detalle de la Plaga"
    @pest = PestDecorator.new(@pest)
  end

  def update
    if @pest.update(pest_nested_params)
      flash[:notice] = "La plaga fue actualizada correctamente."
      redirect_to config_production_pest_url(@pest, tab: :general)
    else
      render :edit
    end
  end

  def destroy
    @pest.destroy
  end

  def update_pictures
    @pest = Pest.find(params[:id])
    @pest.update(pest_picture_params)
    redirect_to config_production_pest_url(@pest, tab: :general)
  end

  private

  def pest_nested_params
    params.require(:pest).permit(:name, :scientific_name, 
      :description, pictures: [],
      crops_pests_attributes: [:id, :crop_id, :pest_id, :_destroy])
  end

  def pest_picture_params
    params.require(:pest).permit(pictures: [])
  end

  def pest_params
    params.require(:pest).permit(:name, :scientific_name, 
      :description, pictures: [])
  end

  def find_pest
    @pest = Pest.find(params[:id])
    if params[:tab] == "treatments"
      treatments = @pest.treatments
      @treatments = []
      treatments.each do |t|
        hash = {
          id: t.id,
          crop_name: t.crop_name,
          supply_count: t.treatment_supplies.size,
          supplies: build_supply_hash(t.treatment_supplies)
        }
        t.destroy unless t.treatment_supplies.size > 0
        @treatments.push(hash) if t.treatment_supplies.size > 0
      end
    end
  end

  def build_supply_hash(treatment_supplies)
    delete_non_existing_supplies(treatment_supplies)
    treatment_supplies.flat_map do |treatment_supply|
      {
        id: treatment_supply.supply.id,
        name: treatment_supply.supply_name,
        foliar_quantity: treatment_supply.foliar_quantity,
        foliar_unit: treatment_supply.foliar_unit,
        irrigation_quantity: treatment_supply.irrigation_quantity,
        irrigation_unit: treatment_supply.irrigation_unit,
      }
    end
  end 

  def delete_non_existing_supplies(treatment_supplies)
    treatment_supplies.each do |treatment_supply|
      treatment_supply.destroy unless Supply.all.ids.include?(treatment_supply.supply_id)
    end
  end

  def set_crop
    @crop = Crop.find(params[:crop_id]) if params[:crop_id].present?
  end

  def set_params
    @create_params = params[:crop_id].present? ? pest_params : pest_nested_params
    @pest = Pest.new(@create_params)
  end
end