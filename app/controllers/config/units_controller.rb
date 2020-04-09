module Config
  class UnitsController < ApplicationController
  	before_action :set_catalogs, only: %i[index new edit create update]
  	before_action :set_object, only: %i[show edit update destroy]
    add_breadcrumb "Config"
  	add_breadcrumb "Unidades", :config_units_path

  	def index
  		@units = Unit.paginate(page: params[:page], per_page: 16)
  		search if params[:q].present?
      search_by_carrier if params[:c].present?
  	end

  	def new
      add_breadcrumb "Nuevo"
      @unit = Unit.new
  	end

    def edit
      add_breadcrumb "Editar"
    end

    def create
      @unit = Unit.new(unit_params)
      if @unit.save
        redirect_to config_units_url, notice: 'Unidad creada'
      else
        render :new
      end
    end

    def update
	    if @unit.update(unit_params)
	      flash[:notice] = "Unidad actualizada"
	    	redirect_to config_units_url, notice: 'Unidad actualizada'
	    else
	      render :edit
	    end
	  end

    def show
    	add_breadcrumb "Detalle"
    end

  	def destroy
    	@unit.destroy
  	end

    private
		
		def search
      q = Regexp.escape(params[:q])
      @units = @units.where(
        "concat(model, ' ', color, ' ', year) ~* ?", q)
    end

    def search_by_carrier
      c = Regexp.escape(params[:c])
      @units = @units.where(carrier_id: c)
    end
    
    def unit_params
			params.require(:unit).permit(:model, :color, :year, :n_econ,  
				:plate_number, :carrier_id, :unit_brand_id, :picture)
	  end

	  def set_object
    	@unit = Unit.find(params[:id])
  	end

    def set_catalogs
    	@carriers = Carrier.all.pluck(:name, :id)
    	@brands = UnitBrand.all
    end
  end
end
