class SizesController < ApplicationController
	before_action :set_object, only: %i[show edit update destroy]

  add_breadcrumb "Tamaños", :sizes_path

  def index
  	@sizes = Size.paginate(page: params[:page], per_page: 16)
    search if params[:q].present?
  end

  def new
    add_breadcrumb "Nuevo"
  	@size = Size.new
  end

  def edit
    add_breadcrumb "Editar"
  end

  def show
    add_breadcrumb "Detalle" 
  end

  def create
  	@size = Size.new(size_params)
    respond_to do |format|
      if @size.save
        format.html { redirect_to sizes_url, notice: 'Tamaño creado.' }
      else
        format.html { render :new }
      end
    end
  end

   def update
    if @size.update(size_params)
      flash[:notice] = "Tamaño #{@size.name} Actualizado"
      redirect_to sizes_url
    else
      render :edit
    end
  end

  def destroy
    @size.destroy
  end

	private

  def search
    q = Regexp.escape(params[:q])
    
    @sizes = @sizes.where("name ~* ?", q)
  end

	def size_params
    params.require(:size).permit(:name, :short_name)
  end

  def set_object
    @size = Size.find(params[:id])
  end
end
