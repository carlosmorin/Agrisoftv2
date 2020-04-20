class ShipmentsController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy]

  def index
    @shipments = Shipment.all
  end

  def new
    @shipment = Shipment.new
    @shipment.remissions.build.remissions_products.build
  end

  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      flash[:notice] = "Embarque <b>190274</b> creado exitosamente"
      redirect_to shipment_url(@shipment)
    else
      render :new
    end
  end

  def update
    if @shipment.update(shipment_params)
      flash[:notice] = "Embarque <b>190274</b> actualizado exitosamente"
      redirect_to shipment_url(@shipment)
    else
      render :edit
    end
  end

  private

  def set_object
    @shipment = Shipment.find(params[:id])
  end

  def shipment_params
  	params.require(:shipment).permit(
      :carrier_id, :driver_id, :unit_id, :box_id, :user_id,
        remissions_attributes: [:id, :company_id, :client_id, :delivery_address_id, :comments, :_destroy, :pay_freight,
          remissions_products_attributes: [:id, :price, :quantity, :remission_id, :product_id, :_destroy]]
    )
  end
end