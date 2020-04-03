class TaxesController < ApplicationController
	before_action :set_object, only: %i[edit update destroy]
	
	def index
		@taxes = Tax.all
	end

	def new
		@tax = Tax.new
	end

  def create
    @tax = Tax.new(tax_params)
    respond_to do |format|
      if @tax.save
        format.html { redirect_to taxes_url, notice: 'Impuesto creado.' }
        format.json { render :show, status: :created, location: @tax }
      else
        format.html { render :new }
        format.json { render json: @tax.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @tax.update(tax_params)
      flash[:notice] = "#{@tax.name} Actualizado"
      redirect_to taxes_url
    else
      render :edit
    end
  end

  def destroy
    @tax.destroy
  end
	
  private

	def tax_params
    params.require(:tax).permit(:name, :value)
  end

  def set_object
    @tax = Tax.find(params[:id])
  end
end