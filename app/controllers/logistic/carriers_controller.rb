module Logistic
  class CarriersController < ApplicationController
    before_action :set_object, 
      only: %i[show edit update destroy get_drivers get_units get_boxes]
    before_action :set_catalogs, only: %i[edit update]
    add_breadcrumb "Transportistas", :logistic_carriers_path
    
    def index
      @carriers = Carrier.paginate(page: params[:page], per_page: 16)
      search if params[:q].present?
    end

    def new
      add_breadcrumb "Nuevo"
      @carrier = Carrier.new
      @countries = Country.new
    end

    def edit
      add_breadcrumb "Editar"
    end

    def show
      add_breadcrumb "Detalle"
    end

    def create
      @carrier = Carrier.new(carrier_params)
      respond_to do |format|
        if @carrier.save
          format.html { redirect_to carrier_url(@carrier), notice: 'Transportista creado' }
        else
          format.html { render :new }
        end
      end
    end

    def update
      if @carrier.update(carrier_params)
        flash[:notice] = "#{@carrier.name} Actualizado"
        redirect_to carrier_url(@carrier)
      else
        render :edit
      end
    end

    def destroy
      @carrier.destroy
    end

    def get_drivers
      drivers = @carrier.drivers
      render json: drivers
    end

    def get_units
      units = @carrier.units
      render json: units
    end

    def get_boxes
      boxes = @carrier.boxes
      render json: boxes
    end
  	
    private

    def search
      q = Regexp.escape(params[:q])
      
      @carriers = @carriers.where("concat(name, ' ', rfc, ' ', phone) ~* ?", q)
    end

  	def carrier_params
      params.require(:carrier).permit(
        :name, :rfc, :phone, :country_id, :state_id, :address, :cp, 
        :municipality_id, :email, :contact_name, :caat, :alpha, :iccmx, :usdot)
    end

    def set_object
      id = params[:id].present? ? params[:id] : params[:carrier_id] 
      @carrier = Carrier.find(id)
    end

    def set_catalogs
      country = Country.find(@carrier.country_id)
      state = State.find(@carrier.state_id)

      @states = country.states
      @municipalities = state.municipalities
    end
  end
end