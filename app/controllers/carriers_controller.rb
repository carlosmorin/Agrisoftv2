class CarriersController < ApplicationController
  before_action :set_object, only: %i[get_drivers get_units get_boxes]
  
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
	
  def set_object
    id = params[:id].present? ? params[:id] : params[:carrier_id] 
    @carrier = Carrier.find(id)
  end
end