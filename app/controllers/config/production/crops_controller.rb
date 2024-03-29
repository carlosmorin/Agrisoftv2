# frozen_string_literal: true

class Config::Production::CropsController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy get_colors
                                      get_qualities get_sizes get_packages]

  add_breadcrumb 'Produccion', :config_production_root_path
  add_breadcrumb 'Cultivos', :config_production_crops_path

  def index
    @crops = Crop.paginate(page: params[:page], per_page: 16)
    search if params[:q].present?
  end

  def new
    add_breadcrumb 'Nuevo'
    @crop = Crop.new
    @crop.crops_colors.build
    @crop.crops_sizes.build
    @crop.crops_qualities.build
    @crop.crops_packages.build
    @crop.crops_pests.build
    @crop.crops_deseases.build
  end

  def edit
    add_breadcrumb 'Editar'
  end

  def show
    add_breadcrumb 'Detalle'
  end

  def create
    @crop = Crop.new(crop_params)
    if @crop.save
      flash[:notice] = "Cultivo #{@crop.name} creado"
      redirect_to config_production_crops_url
    else
      render :new
    end
  end

  def update
    if @crop.update(crop_params)
      flash[:notice] = "Cultivo #{@crop.name} actualizado"
      redirect_to config_production_crops_url
    else
      render :edit
    end
 end

  def destroy
    @crop.destroy
  end

  def get_crops
    crops = Crop.all.map { |crop| [crop[:name], crop[:id]] }
    render json: crops
  end

  def get_pests
    @crop = Crop.find(params[:id])
    render json: @crop.pests
  end

  def get_deseases
    @crop = Crop.find(params[:id])
    render json: @crop.deseases
  end

  # #End points
  def get_colors
    colors = @crop.colors
    render json: colors
  end

  def get_qualities
    qualities = @crop.qualities
    render json: qualities
  end

  def get_sizes
    sizes = @crop.sizes
    render json: sizes
  end

  def get_packages
    packages = @crop.packages
    render json: packages
  end

  private

  def search
    q = Regexp.escape(params[:q])

    @crops = @crops.where('name ~* ?', q)
  end

  def crop_params
    params.require(:crop).permit(:name,
                                 crops_sizes_attributes: %i[id crop_id size_id _destroy],
                                 crops_qualities_attributes: %i[id crop_id quality_id _destroy],
                                 crops_packages_attributes: %i[id crop_id package_id _destroy],
                                 crops_colors_attributes: %i[id crop_id color_id _destroy],
                                 crops_pests_attributes: %i[id crop_id pest_id _destroy],
                                 crops_deseases_attributes: %i[id crop_id desease_id _destroy])
  end

  def set_object
    id = params[:id].present? ? params[:id] : params[:crop_id]
    @crop = Crop.find(id)
  end
end
