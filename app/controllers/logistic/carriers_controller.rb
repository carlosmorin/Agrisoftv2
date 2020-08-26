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
      @carrier.fiscals.new.addresses.new
      @countries = Country.new
      @states = []
      @municipalities = []
    end

    def edit
      @carrier.fiscals.new.addresses.new unless @carrier.fiscals.present?
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
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Transportista Actualizado correctamente"
        redirect_to logistic_carrier_url(@carrier, tab: :general)
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
        :municipality_id, :email, :contact_name, :caat, :alpha, :iccmx, :usdot,
        fiscals_attributes: [:id, :bussiness_name, :rfc, :_destroy,
          addresses_attributes: [:id, :name, :street, :outdoor_number, :interior_number,
            :cp, :references, :neighborhood, :phone, :country_id, :state_id, 
            :fiscalcrosses, :locality, :fiscal, :crosses, :_destroy]]
      )
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