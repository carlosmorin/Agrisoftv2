class ColorsController < ApplicationController
	before_action :set_object, only: %i[show edit update destroy]

	add_breadcrumb "Colores", :colors_path

  def index
  	@colors = Color.paginate(page: params[:page], per_page: 16)
    search if params[:q].present?
  end

  def new
    add_breadcrumb "Nuevo"
  	@color = Color.new
  end

  def edit
    add_breadcrumb "Editar"
  end

  def show
    add_breadcrumb "Detalle"
  end

  def create
  	@color = Color.new(color_params)
    respond_to do |format|
      if @color.save
        format.html { redirect_to colors_url, notice: 'Color creado.' }
      else
        format.html { render :new }
      end
    end
  end

   def update
    if @color.update(color_params)
      flash[:notice] = "Tamaño #{@color.name} Actualizado"
      redirect_to colors_url
    else
      render :edit
    end
  end

  def destroy
    @color.destroy
  end

	private

  def search
    q = Regexp.escape(params[:q])

    @colors = @colors.where("name ~* ?", q)
  end

	def color_params
    params.require(:color).permit(:name)
  end

  def set_object
    @color = Color.find(params[:id])
  end
end
