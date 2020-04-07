class VegetablesController < ApplicationController
before_action :set_object, only: %i[show edit update destroy]

  def index
  	@vegetables = Vegetable.all
  end

  def new
  	@vegetable = Vegetable.new
  end

  def show
    
  end

  def create
  	@vegetable = Vegetable.new(vegetable_params)
    respond_to do |format|
      if @vegetable.save
        format.html { redirect_to vegetables_url, notice: 'Hortaliza creada.' }
      else
        format.html { render :new }
      end
    end
  end

   def update
    if @vegetable.update(vegetable_params)
      flash[:notice] = "#{@vegetable.name} Actualizada"
      redirect_to vegetables_url
    else
      render :edit
    end
  end

  def destroy
    @vegetable.destroy
  end

	private

	def vegetable_params
    params.require(:vegetable).permit(:name, :value)
  end

  def set_object
    @vegetable = Vegetable.find(params[:id])
  end
end
