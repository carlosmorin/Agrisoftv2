class Config::Production::SuppliesController < ApplicationController
  before_action :set_supply, only: %i[show edit update destroy]
    
  add_breadcrumb "Produccion", :config_production_root_path
  add_breadcrumb "Insumos", :config_production_supplies_path

  def index
  	@supplies = Supply.paginate(page: params[:page], per_page: 16)
    search if params[:q].present?
  end

  def new
    add_breadcrumb "Nuevo"
    @supply = Supply.new
    # @supply.crops_colors.build
    # @supply.crops_sizes.build
    # @supply.crops_qualities.build
    # @supply.crops_packages.build
    # @supply.crops_pests.build
    # @supply.crops_deseases.build
  end

  def edit
    add_breadcrumb "Editar"
  end

  def show
    add_breadcrumb "Detalle del Insumo"   
  end

  def create
  	@supply = Supply.new(supply_params)
    if @supply.save
      flash[:notice] = "Insumo #{ @supply.name } creado correctamente"
      redirect_to config_production_supplies_url
    else
      render :new
    end
  end

   def update
    if @supply.update(supply_params)
      flash[:notice] = "Insumo #{ @supply.name } actualizado correctamente"
      redirect_to config_production_supplies_url
    else
      render :edit
    end
  end

  def destroy
    @supply.destroy
  end

	private

  def search
    q = Regexp.escape(params[:q])
    
    @supplies = @supplies.where("name ~* ?", q)
  end

	def supply_params
    params.require(:supply).permit(:name, :currency, :iva, :ieps, :code, :category_id)   
  end

  def set_supply
    # id = params[:id].present? ? params[:id] : params[:crop_id]
    @supply = Supply.find(params[:id])
  end
end
