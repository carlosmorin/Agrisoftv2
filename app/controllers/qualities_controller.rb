class QualitiesController < ApplicationController
	before_action :set_object, only: %i[show edit update destroy]

	add_breadcrumb "Calidades", :qualities_path

	def index
  	@qualities = Quality.paginate(page: params[:page], per_page: 16)
    search if params[:q].present?
  end

  def new
    add_breadcrumb "Nueva"
  	@quality = Quality.new
  end

  def edit
    add_breadcrumb "Editar"
  end	

def create
  	@quality = Quality.new(quality_params)
    respond_to do |format|
      if @quality.save
        format.html { redirect_to qualities_url, notice: 'Calidad creada.' }
      else
        format.html { render :new }
      end
    end
  end

   def update
    if @quality.update(quality_params)
      flash[:notice] = "Calidad #{@quality.name.upcase} Actualizado"
      redirect_to qualities_url
    else
      render :edit
    end
  end

  def destroy
    @quality.destroy
  end

	private

  def search
    q = Regexp.escape(params[:q])
    
    @qualities = @qualities.where("name ~* ?", q)
  end

	def quality_params
    params.require(:quality).permit(:name)
  end

  def set_object
    @quality = Quality.find(params[:id])
  end

end
