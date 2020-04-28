class CompaniesController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy]
  before_action :set_catalogs, only: %i[edit update]

  add_breadcrumb "Empresas", :companies_path

  def index
  	@companies = Company.paginate(page: params[:page], per_page: 16)
    search if params[:q].present?
  end

  def new
    add_breadcrumb "Nuevo"
  	@company = Company.new
  end

  def show
    add_breadcrumb "Detalle"
  end

  def edit
    add_breadcrumb "Editar"
  end

  def create
  	@company = Company.new(company_params)
      if @company.save
        flash[:notice] = "La empresa fue registrada exitosamente."
        redirect_to company_url(@company)
      else
        render :new
      end
  end

   def update
    if @company.update(company_params)
      flash[:notice] = "Empresa Actualizada"
      redirect_to company_url(@company)
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
  end

	private

  def search
    q = Regexp.escape(params[:q])
    
    @companies = @companies.where("concat(name, ' ', rfc, ' ', phone) ~* ?", q)
  end

	def company_params
    params.require(:company).permit(:name, :rfc, :phone, :country_id, 
      :state_id, :cp, :municipality_id, :address, :email, :contact_name)
  end

  def set_object
    @company = Company.find(params[:id])
  end

  def set_catalogs
    country = Country.find(@company.country_id)
    state = State.find(@company.state_id)

    @states = country.states
    @municipalities = state.municipalities
  end

end
