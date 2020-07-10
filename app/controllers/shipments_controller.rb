class ShipmentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_object, only: %i[show edit update destroy print 
    print_responsive]
  before_action :set_collections, only: %i[edit new update create]
  add_breadcrumb "Embarques", :shipments_path
  before_action :create_freight, only: [:edit] , if: -> { @shipment.freight.nil? }

  def index
    @shipments = Shipment.shipment.paginate(page: params[:page], per_page: 25)
    @all_shipments = Shipment.shipment
    @orders = Shipment.order_sale if params[:tab] == "order_sale"

    search if params[:q].present?
    search_by_client if params[:c].present?
  end

  def new
    add_breadcrumb "Nuevo"

    @shipment = Freight.new
    @shipment.shipments.build.shipments_products.build
  end
  
  def edit
    add_breadcrumb "Editar"
  end

  def show
    add_breadcrumb "Detalle"
  end
  
  def create
    @shipment = Freight.new(shipment_params)
    if @shipment.save
      flash[:notice] = "Embarque <b>#{@shipment.folio.upcase}</b> creada exitosamente"
      redirect_to shipment_url(@shipment.shipments.first)
		else
      render :new
    end
  end

  def update
    @shipment.status = :shipment
    if @shipment.freight.update(shipment_params)
      flash[:notice] = "Embarque <b>#{@shipment.folio}</b> actualizado
        exitosamente"
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

  def create_freight
    Freight.new(user_id: current_user.id).save(validate: false) 
    @shipment.update(freight_id: Freight.last.id)
  end
  
  def set_collections
    @drivers = Driver.all.pluck(:name, :id)
    @units = Unit.all.pluck(:name, :id)
    @boxes = Box.all.pluck(:name, :id)
    @delivery_addresses = DeliveryAddress.all.pluck(:name, :id)
  end

  def search_by_client
    client_id = params[:c]
    
    @shipments = @shipments.where(client_id: client_id)
  end

  def search
    query = Regexp.escape(params[:q])

    @shipments = @shipments.where("concat(folio, ' ', client_folio, ' ', 
      freight_folio, ' ', n_products) ~* ?", query)
  end

	def set_object
    id = params[:id].present? ? params[:id] : params[:shipment_id] 
    @shipment = Shipment.find(id)
  end

  def shipment_params
  	params.require(:freight).permit(
      :carrier_id, :driver_id, :unit_id, :box_id, :user_id,
          shipments_attributes: [:id, :company_id, :client_id,
            :delivery_address_id, :comments, :status, :_destroy, :pay_freight,
          shipments_products_attributes: [:id, :price, :quantity, :shipment_id,
            :product_id, :_destroy]]
    )
  end
end
