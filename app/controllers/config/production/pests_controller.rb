class Config::Production::PestsController < ApplicationController
  before_action :find_pest, only: %i[show edit destroy update]
  before_action :set_crop, only: %i[new update]

  add_breadcrumb "Produccion", :config_production_root_path
  add_breadcrumb "Plagas", :config_production_pests_path

  def index
    @index_facade = Pests::IndexFacade.new(params)
  end

  def create
    @pest = Pest.new(pest_params)
    if @pest.save
      flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Plaga creada correctamente"
      redirect_to config_production_pest_url(@pest, tab: :general)
    else
      flash.now[:alert] = "<i class='fa fa-check-circle mr-1 s-18'></i>  #{@pest.errors.full_messages[0]}"
      render :new
    end
  end

  def new
    add_breadcrumb "Nuevo"
    @pest = Pest.new
  end

  def edit
    add_breadcrumb "Editar"
  end

  def show
    add_breadcrumb "Detalle de la Plaga"
    @pest = Pests::PestDecorator.new(@pest)
  end

  def update
    if @pest.update(pest_params)
      flash[:notice] = "La plaga fue actualizada correctamente."
      redirect_to config_production_pest_url(@pest, tab: :general)
    else
      render :edit
    end
  end

  def destroy
    @pest.destroy
  end

  private

  def pest_params
    params.require(:pest).permit(:name, :scientific_name, 
      :description, pictures: [],
      crops_pests_attributes: [:id, :crop_id, :pest_id, :_destroy])
  end

  def find_pest
    @pest = Pest.find(params[:id])
  end

  def set_crop
    @crop = Crop.find(params[:crop_id]) if params[:crop_id].present?
  end
end