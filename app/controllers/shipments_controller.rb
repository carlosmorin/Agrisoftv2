class ShipmentsController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy print]

  def index
    @shipments = Shipment.all
  end

  def new
    @shipment = Freight.new
    @shipment.shipments.build.shipments_products.build
  end

  def create
    @shipment = Freight.new(shipment_params)
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

  def print
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Remision N° #{@shipment}",
        page_size: 'A4',
        template: "shipments/print.html.slim",
        layout: "pdf.html",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end
  end

  private

  def set_object
    id = params[:id].present? ? params[:id] : params[:shipment_id] 
    @shipment = Shipment.find(id)
    @freight = @shipment.freight
  end

  def shipment_params
  	params.require(:freight).permit(
      :carrier_id, :driver_id, :unit_id, :box_id, :user_id,
        shipments_attributes: [:id, :company_id, :client_id, :delivery_address_id, :comments, :_destroy, :pay_freight,
          shipments_products_attributes: [:id, :price, :quantity, :shipment_id, :product_id, :_destroy]]
    )
  end
end