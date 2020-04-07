module Config
  class DriversController < ApplicationController
		before_action :set_object, only: %i[show edit update destroy]
		before_action :set_carriers, only: %i[new edit index create]
    add_breadcrumb "Conductores", :config_drivers_path

  	def index
  		@drivers = Driver.paginate(page: params[:page], per_page: 15)
      search if params[:q].present?
      search_by_carrier if params[:c].present?
    end

  	def new
      add_breadcrumb "Nuevo"

			@driver = Driver.new
		end

    def show
      add_breadcrumb "Detalle"
    end

    def edit
      add_breadcrumb "Editar"
    end

	  def create
	    @driver = Driver.new(driver_params)
      if @driver.save
      	flash[:notice] = "Conductor creado"
    		redirect_to config_drivers_url
      else
        render :new, collection: @carriers
      end
	  end

	  def update
    	if @driver.update(driver_params)
      	flash[:notice] = "Conductor actualizado"
      	redirect_to config_drivers_url
    	else
      	render :edit, collection: @carriers
    	end
  	end

  	def destroy
    	@driver.destroy
  	end
	
	  private

    def search
      q = Regexp.escape(params[:q])
      @drivers = @drivers.where(
        "concat(name, ' ', last_name, ' ', licence) ~* ?", q)
    end

    def search_by_carrier
      c = Regexp.escape(params[:c])
      @drivers = @drivers.where(carrier_id: c)
    end

	  def driver_params
			params.require(:driver).permit(
				:name, :last_name, :phone, :licence, :carrier_id, licence_imgs: [])
	  end

	  def set_object
    	@driver = Driver.find(params[:id])
  	end

  	def set_carriers
  		@carriers = Carrier.all.pluck(:name, :id)
  	end 
  end
 end