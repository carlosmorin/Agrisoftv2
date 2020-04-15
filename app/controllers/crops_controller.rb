class CropsController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy]

  add_breadcrumb "Cultivos", :crops_path

  def index
  	@crops = Crop.paginate(page: params[:page], per_page: 16)
    search if params[:q].present?
  end

  def new
    add_breadcrumb "Nuevo"
  	@crop = Crop.new
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

	private

  def search
    q = Regexp.escape(params[:q])
    
    @crops = @crops.where("name ~* ?", q)
  end

	def crop_params
    params.require(:crop).permit(:name)
  end

  def set_object
    @crop = Crop.find(params[:id])
  end
end
