class ProvidersController < ApplicationController
	before_action :set_object, only: %i[show edit update destroy]

  add_breadcrumb "Proveedores", :providers_path

	def index
  	@providers = Provider.paginate(page: params[:page], per_page: 25)

    search if params[:q].present?
  end

  def new
    add_breadcrumb "Nuevo proveedor"
  	@provider = Provider.new
  end

  def edit
    add_breadcrumb "Editar"
  end	

  def create
    @provider = Provider.new(provider_params)
    
    if @provider.save
      msg = "Proveedor creado correctamente <i class='fas fa-check-circle ml-2'></i>"
      flash[:notice] = msg
      redirect_to providers_url
    else
      add_breadcrumb "Nuevo proveedor"
      render :new
    end
  end

   def update
    if @provider.update(provider_params)
      msg = "Proveedor actualizado correctamente <i class='fas fa-check-circle ml-2'></i>"
      flash[:notice] = msg
      redirect_to provider_path(@provider)
    else
      render :edit
    end
  end

  def destroy
    @provider.destroy
  end

	private

  def search
    q = Regexp.escape(params[:q])
    
    @providers = @providers.where("name ~* ?", q)
  end

	def provider_params
    params.require(:provider).permit(:name, :business_name, :rfc, :email, 
      :phone, :status, :comments, :logo, 
        addresses_attributes: [:id, :name, :street, :outdoor_number, 
          :interior_number, :cp, :references, :locality, :neighborhood, 
          :country_id, :state_id, :comments, :type, :_destroy]
    )
  end

  def set_object
    @provider = Provider.find(params[:id])
  end

end
