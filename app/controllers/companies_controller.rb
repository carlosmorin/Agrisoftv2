class CompaniesController < ApplicationController
before_action :set_object, only: %i[show edit update destroy]

  def index
  	@companies = Company.all
  end

  def new
  	@company = Company.new
  end

  def show
    
  end

  def create
  	@company = Company.new(company_params)
    respond_to do |format|
      if @company.save
        format.html { redirect_to companies_url, notice: 'La empresa fue registrada exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

   def update
    if @company.update(company_params)
      flash[:notice] = "#{@company.name} Actualizada"
      redirect_to companies_url
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
  end

	private

	def company_params
    params.require(:company).permit(:name, :rfc, :phone, :country, :state, :cp, :address, :value)
  end

  def set_object
    @company = Company.find(params[:id])
  end
end
