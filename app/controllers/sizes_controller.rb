class SizesController < ApplicationController
	before_action :set_object, only: %i[show edit update destroy]

  def index
  	@sizes = Size.all
  end

  def new
  	@size = Size.new
  end

  def show
    
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

	def size_params
    params.require(:size).permit(:name, :value)
  end

  def set_object
    @size = Size.find(params[:id])
  end
end
