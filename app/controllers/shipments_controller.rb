class ShipmentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_object, only: %i[show edit update destroy print 
    consolidate]
  before_action :set_collections, only: %i[edit new update create]
  before_action :create_freight, only: [:edit] , if: -> { @shipment.freight.nil? }
  
  add_breadcrumb "Embarques", :shipments_path

  def index
    @shipments = Shipment.sale
                  .order('folio DESC')
                  .joins(products: [:crop, :color, :quality])
                  .includes(products: [:crop, :color, :quality])

    @orders_sales = Shipment.left_outer_joins(:appointments).active_order_sales_shipments
    @all_shipments = Shipment.sale
    @orders = @orders_sales if params[:tab] == "order_sale"

    search if params[:q].present?
    search_by_client if params[:c].present?

    xls_export if params[:format].present?
    @shipments = @shipments.paginate(page: params[:page], per_page: 25)
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

  def consolidate
    add_breadcrumb @shipment.folio, shipment_path(@shipment)
    add_breadcrumb "Consolidar"
    freight_id = @shipment.freight_id
    @shipment = Shipment.new(freight_id: freight_id)
    @shipment.shipments_products.new
  end

  def create
    @shipment = Freight.new(shipment_params) if params[:type] == "normal"
    @shipment = Shipment.new(consolidate_params) if params[:type] == "consolidate"

    if @shipment.save
      flash[:notice] = "Embarque <b>#{@shipment.folio.upcase}</b> creada exitosamente"
      redirect_to shipment_url(@shipment) if params[:type] == "consolidate"
      redirect_to shipment_url(@shipment.shipments.first) if params[:type] == "normal"
		else
      add_breadcrumb "Nuevo"
      render :new
    end
  end

  def update
    @shipment.status = :sale
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
    q = Regexp.escape(params[:q])
    query = Regexp.escape(params[:q])

    @shipments = @shipments.where("concat(folio, ' ', client_folio, ' ', 
      freight_folio, ' ', n_products) ~* ?", query)
  end

  def search_by_crop
    crop_id = params[:crop_id]
    @shipments = @shipments.where("products.crop_id = ?", crop_id)
  end

  def search_by_quality
    quality_id = params[:quality_id]
    @shipments = @shipments.where("products.quality_id = ?", quality_id)
  end

  def search_by_package
    package_id = params[:package_id]
    @shipments = @shipments.where("products.package_id = ?", package_id)
  end


	def set_object
    id = params[:id].present? ? params[:id] : params[:shipment_id] 

    @shipment = Shipment.find(id)
  end

  def shipment_params
  	params.require(:freight).permit(
      :carrier_id, :driver_id, :unit_id, :box_id, :user_id,
          shipments_attributes: [:id, :company_id, :client_id, :n_pallets, :shipment_at,
            :delivery_address_id, :user_id, :status, :comments, :_destroy, :pay_freight,
          shipments_products_attributes: [:id, :price, :quantity, :shipment_id,
            :product_id, :_destroy]]
    )
  end

  def consolidate_params
    params.require(:shipment).permit(:id, :company_id, :client_id, :n_pallets,
      :delivery_address_id, :user_id, :freight_id, :status, :comments, :_destroy, :pay_freight,
      shipments_products_attributes: [ :id, :price, :quantity, :shipment_id, 
        :product_id, :_destroy ]
    )
  end

  def xls_export
    render xlsx: "Embarques", template: "shipments/index.xlsx.axlsx"
  end
end
