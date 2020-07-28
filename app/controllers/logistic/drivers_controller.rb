module Logistic
  class DriversController < ApplicationController
    before_action :set_object, only: %i[show edit update destroy]
    before_action :set_carriers, only: %i[index]
    before_action :set_carrier, only: %i[new edit]

    def index
      @drivers = Driver.paginate(page: params[:page], per_page: 16)
      search if params[:q].present?
      search_by_carrier if params[:c].present?
    end

    def new
      add_breadcrumb "Logistica", :logistic_root_path if params[:carrier_id].present?
      add_breadcrumb "Transportistas", :logistic_carriers_path if params[:carrier_id].present?
      add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :operators) if params[:carrier_id].present?
      add_breadcrumb "Nuevo Conductor"
      @driver = Driver.new
    end

    def show
      carrier = @driver.carrier
      add_breadcrumb "Logistica", :logistic_root_path
      add_breadcrumb "Transportistas", :logistic_carriers_path
      add_breadcrumb carrier.name.upcase, logistic_carrier_path(carrier)
      add_breadcrumb "Operadores", logistic_carrier_path(carrier, tab: :operators)
      add_breadcrumb @driver.full_name.upcase
    end

    def edit
      add_breadcrumb "Logistica", :logistic_root_path if params[:carrier_id].present?
      add_breadcrumb "Transportistas", :logistic_carriers_path if params[:carrier_id].present?
      add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :operators) if params[:carrier_id].present?
      add_breadcrumb "Operadores", logistic_carrier_path(@carrier, tab: :operators) if params[:carrier_id].present?
      add_breadcrumb @driver.name.upcase, logistic_carrier_driver_path(@carrier, @driver)
      add_breadcrumb "Editar"
    end

    def create
      @driver = Driver.new(driver_params)
      if @driver.save
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Conductor creado correctamente"
        redirect_to logistic_carrier_url(@driver.carrier_id, tab: :operators)
      else
        @carrier = @driver.carrier
        add_breadcrumb "Logistica", :logistic_root_path
        add_breadcrumb "Transportistas", :logistic_carriers_path
        add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :operators)
        add_breadcrumb "Nuevo Conductor"
        render template: 'logistic/drivers/new'
      end
    end

    def update
      if @driver.update(driver_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Conductor actualizado correctamente"
        redirect_to  logistic_carrier_driver_path(@driver.carrier, @driver) 
      else
        render template: 'logistic/drivers/new'
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
        :name, :last_name, :phone, :licence, :carrier_id, :licence_img)
    end

	  def set_object
    	@driver = Driver.find(params[:id])
  	end

  	def set_carriers
  		@carriers = Carrier.all.pluck(:name, :id)
  	end 
    
    def set_carrier
      @carrier = params[:carrier_id].present? ?
        Carrier.find(params[:carrier_id]) : @driver.carrier
    end    
  end
 end