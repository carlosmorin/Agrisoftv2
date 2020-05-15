module Logistic
  class UnitsController < ApplicationController
    before_action :set_catalogs, only: %i[index new edit create update]
    before_action :set_object, only: %i[show edit update destroy]

    def index
      @units = Unit.paginate(page: params[:page], per_page: 16)
      
      search if params[:q].present?
      search_by_carrier if params[:c].present?
    end

    def new
      @carrier = Carrier.find(params[:carrier_id])
      add_breadcrumb "Transportistas", logistic_carriers_path
      add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :general)
      add_breadcrumb "Unidades", logistic_carrier_path(@carrier, tab: :units)
      add_breadcrumb "Nuevo"
      @unit = Unit.new
    end

    def edit
      add_breadcrumb "Transportistas", logistic_carriers_path
      add_breadcrumb @unit.carrier.name.upcase, logistic_carrier_path(@unit.carrier, tab: :general)
      add_breadcrumb "Unidades", logistic_carrier_path(@unit.carrier, tab: :units)
      add_breadcrumb @unit.short_name.upcase, logistic_carrier_unit_path(@unit.carrier, @unit)
      add_breadcrumb "Editar"
    end

    def create
      @unit = Unit.new(unit_params)
      if @unit.save
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  
          Unidad creada correctamente"
        redirect_to logistic_carrier_url(@unit.carrier, tab: :units)
      else
        render :new
      end
    end

    def update
      if @unit.update(unit_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  
          Unidad actualizada correctamente"
        redirect_to logistic_carrier_url(@unit.carrier, tab: :units)
      else
        render :edit
      end
    end

    def show
      add_breadcrumb "Transportistas", logistic_carriers_path
      add_breadcrumb @unit.carrier.name.upcase, logistic_carrier_path(@unit.carrier, tab: :general)
      add_breadcrumb "Unidades", logistic_carrier_path(@unit.carrier, tab: :units)
      add_breadcrumb @unit.short_name.upcase
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
