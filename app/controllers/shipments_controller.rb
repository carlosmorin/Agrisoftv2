class ShipmentsController < ApplicationController
  def index
  	@shipments = Shipment.all
  end

  def new
  	@shipment = Shipment.new
  	@shipment.remissions.build
  end

  private

  def shipment_params
  	params.require(:shipment).permit(
      :carrier_id, :driver_id, :unit_id, :box_id, :user_id,
       remissions_attributes: [ :id, :company_id, :client_id, :delivery_address_id, :pay_freight])
  end

 end