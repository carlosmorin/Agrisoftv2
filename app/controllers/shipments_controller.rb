class ShipmentsController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy print print_responsive]

  def index
    @shipments = Shipment.all

    search if params[:q].present? 
  end

  def new
    @shipment = Freight.new
    @shipment.shipments.build.shipments_products.build
  end

  def create
    @shipment = Freight.new(shipment_params)
    if @shipment.save
      flash[:notice] = "Embarque #{@shipment.folio.upcase} creada exitosamente"
      redirect_to shipment_url(@shipment)
    else
      render :new
    end
  end

  def update
    if @freight.update(shipment_params)
      flash[:notice] = "Embarque #{@shipment.folio.upcase} actualizado exitosamente"
      redirect_to shipment_url(@shipment)
    else
      render :edit
    end
  end

  def print
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Remision N° #{@shipment.folio}",
        page_size: 'A4',
        template: "shipments/print.html.slim",
        layout: "pdf.html",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end
  end

  def print_responsive
    respond_to do |format|
      format.html 
      format.pdf do
        render pdf: "Responsiva N° #{@shipment.folio}",
        page_size: 'A4',
        template: "shipments/print_responsive.html.slim",
        layout: "pdf.html",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end
  end

  def destroy
    @shipment.destroy
    @freight.destroy
  end

  private

  def search
    query = Regexp.escape(params[:q])

    @shipments = @shipments.where("concat(folio, ' ', client_folio, ' ', contact_name) ~* ?", query)
  end

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