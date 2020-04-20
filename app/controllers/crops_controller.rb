class CropsController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy get_colors 
    get_qualities get_sizes get_packages]
  add_breadcrumb "Cultivos", :crops_path

  def index
  	@crops = Crop.paginate(page: params[:page], per_page: 16)
    search if params[:q].present?
  end

  def new
    add_breadcrumb "Nuevo"
    @crop = Crop.new
    @crop.crops_colors.build
    @crop.crops_sizes.build
    @crop.crops_qualities.build
    @crop.crops_packages.build
  end

  def edit
    add_breadcrumb "Editar"
  end

  def show
    add_breadcrumb "Detalle"   
  end

  def create
  	@crop = Crop.new(crop_params)
    if @crop.save
      flash[:notice] = "Cultivo #{ @crop.name } creado"
      redirect_to crops_url
    else
      render :new
    end
  end

   def update
    if @crop.update(crop_params)
      flash[:notice] = "Cultivo #{ @crop.name } actualizado"
      redirect_to crops_url
    else
      render :edit
    end
  end

  def destroy
    @crop.destroy
  end

  ##End points
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
    
    @crops = @crops.where("name ~* ?", q)
  end

	def crop_params
    params.require(:crop).permit(:name, 
      crops_sizes_attributes: [:id, :crop_id, :size_id, :_destroy],
      crops_qualities_attributes: [:id, :crop_id, :quality_id, :_destroy],
      crops_packages_attributes: [:id, :crop_id, :package_id, :_destroy],
      crops_colors_attributes: [:id, :crop_id, :color_id, :_destroy])
  end

  def set_object
    id = params[:id].present? ? params[:id] : params[:crop_id]
    @crop = Crop.find(id)
  end
end
