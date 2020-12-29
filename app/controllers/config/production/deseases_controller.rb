# frozen_string_literal: true

class Config::Production::DeseasesController < ApplicationController
  before_action :find_desease, only: %i[show edit destroy update]
  before_action :set_crop, only: %i[new update]
  before_action :set_params, only: %i[create]

  add_breadcrumb 'Produccion', :config_production_root_path
  add_breadcrumb 'Enfermedades', :config_production_deseases_path

  def index
    @index_facade = Deseases::IndexFacade.new(params)
  end

  def create
    if @desease.save
      if params[:crop_id].present?
        @crop_pest = @desease.crops_deseases.new(crop_id: params[:crop_id])
      end
      @crop_pest&.save
      flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Enfermedad creada correctamente"
      if params[:crop_id].present?
        return redirect_to config_production_crop_path(params[:crop_id], tab: :deseases)
      end

      return redirect_to config_production_desease_url(@desease, tab: :general)
    else
      return render :new unless params[:crop_id].present?
    end
    flash[:alert] = DeseaseDecorator.new(@desease).display_errors.to_s
    redirect_to new_config_production_crop_desease_path(params[:crop_id])
  end

  def new
    add_breadcrumb 'Nuevo'
    @desease = Desease.new
    @desease.crops_deseases.build
  end

  def edit
    add_breadcrumb 'Editar'
  end

  def show
    add_breadcrumb 'Detalle de la Enfermedad'
    @desease = DeseaseDecorator.new(@desease)
  end

  def update
    if @desease.update(desease_nested_params)
      flash[:notice] = 'La enfermedad fue actualizada correctamente.'
      redirect_to config_production_desease_url(@desease, tab: :general)
    else
      render :edit
    end
  end

  def destroy
    @desease.destroy
  end

  def update_pictures
    @desease = Desease.find(params[:id])
    @desease.update(desease_picture_params)
    redirect_to config_production_desease_url(@desease, tab: :general)
  end

  private

  def desease_nested_params
    params.require(:desease).permit(:name, :scientific_name,
                                    :pathogen, :desease_name,
                                    :development_conditions, pictures: [],
                                                             crops_deseases_attributes: %i[id crop_id desease_id _destroy])
  end

  def desease_picture_params
    params.require(:desease).permit(pictures: [])
  end

  def desease_params
    params.require(:desease).permit(:name, :scientific_name,
                                    :pathogen, :desease_name,
                                    :development_conditions, pictures: [])
  end

  def find_desease
    @desease = Desease.find(params[:id])
    if params[:tab] == 'treatments'
      treatments = @desease.treatments
      @treatments = []
      treatments.each do |t|
        hash = {
          id: t.id,
          crop_name: t.crop_name,
          supply_count: t.treatment_supplies.size,
          supplies: build_supply_hash(t.treatment_supplies)
        }
        t.destroy if t.treatment_supplies.empty?
        @treatments.push(hash) unless t.treatment_supplies.empty?
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
        irrigation_unit: treatment_supply.irrigation_unit
      }
    end
  end

  def delete_non_existing_supplies(treatment_supplies)
    treatment_supplies.each do |treatment_supply|
      unless Supply.all.ids.include?(treatment_supply.supply_id)
        treatment_supply.destroy
      end
    end
  end

  def set_crop
    @crop = Crop.find(params[:crop_id]) if params[:crop_id].present?
  end

  def set_params
    @create_params = params[:crop_id].present? ? desease_params : desease_nested_params
    @desease = Desease.new(@create_params)
  end
end
