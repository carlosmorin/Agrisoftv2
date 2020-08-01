module Logistic
  class CarriersController < ApplicationController
    include Breadcrumbs::Logistic::Carriers

    before_action :set_object, 
      only: %i[show edit update destroy get_drivers get_units get_boxes]
    before_action :set_catalogs, only: %i[edit update]
    before_action :build_breadcrumbs, only: %i[new edit update create]
    
    def index
      @carriers = Carrier.paginate(page: params[:page], per_page: 16)
      search if params[:q].present?
    end

    def new
      @carrier = Carrier.new
      @countries = Country.new
    end

    def edit
    end

    def show
      add_breadcrumb @carrier.name.upcase
    end

    def create
      @carrier = Carrier.new(carrier_params)
      if @carrier.save
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Transportista creado correctamente"
        redirect_to logistic_carrier_url(@carrier, tab: :general)
      else
        render :new
      end
    end

    def update
      if @carrier.update(carrier_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Transportista creado Actualizado"
        redirect_to logistic_carrier_url(@carrier)
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