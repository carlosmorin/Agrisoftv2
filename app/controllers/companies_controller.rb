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
      if @company.save
        flash[:notice] = "La empresa fue registrada exitosamente."
        redirect_to companies_url
      else
        render :new
      end
  end

   def update
    if @company.update(company_params)
      flash[:notice] = "Comprañia Actualizada"
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
    params.require(:company).permit(:name, :rfc, :phone, :country_id, 
      :state_id, :cp, :municipality_id, :address, :value)
  end

  def set_object
    @company = Company.find(params[:id])
  end
end
