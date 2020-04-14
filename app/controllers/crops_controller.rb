class CropsController < ApplicationController
before_action :set_object, only: %i[show edit update destroy]

  def index
  	@crops = Crop.all
  end

  def new
  	@crop = Crop.new
  end

  def show    
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

	def crop_params
    params.require(:crop).permit(:name, :value)
  end

  def set_object
    @crop = Crop.find(params[:id])
  end
end
