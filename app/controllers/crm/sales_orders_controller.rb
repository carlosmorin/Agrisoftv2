module Crm
  class SalesOrdersController < ApplicationController
  	before_action :set_object, only: %i[show edit update print]

    add_breadcrumb "CRM", :crm_root_path
    add_breadcrumb "Ordenes de venta", :crm_sales_orders_path

    def index
    	@order_sales = Shipment.order_sale
                        .order('order_sale_folio DESC')
                        .joins(:products)
                        .includes(:products)
                        .paginate(page: params[:page], per_page: 25)
      @quotes = Shipment.quotation
      search if params[:q].present?
      search_by_client if params[:c].present?
    end

    def new 
      add_breadcrumb "Nueva"
      @order_sale = Shipment.new(status: :order_sale)
      @order_sale.shipments_products.build
    end

    def edit
      add_breadcrumb "Editar"
    end

    def show
      add_breadcrumb "Detalle de orden de venta"
    end

    def create
      @order_sale = Shipment.new(order_sale_params)
      @order_sale.status = :order_sale
      if @order_sale.save
        flash[:notice] = "<i class='fa fa-check-circle mr-2'></i> Orden de venta creada exitosamente"
        redirect_to crm_sales_order_path(@order_sale)
      else
        add_breadcrumb "Nueva"
        render :new
      end
    end

    def update
      @order_sale.status = :order_sale if @order_sale.status != :order_sale
      if @order_sale.update(order_sale_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-2'></i> Orden de venta actualizada exitosamente"
        redirect_to crm_sales_order_path(@order_sale)
      else
        render :edit
      end
    end

    def destroy
      @order_sale.destroy
    end

    def order_sale_params
      params.require(:shipment).permit(:client_id, :company_id, :contact_id,
        :user_id, :expirated_days, :expired_at, :status, :iva, :delivery_address_id,
        :issue_at, :discount, :currency, :exchange_rate, :description, shipments_products_attributes: [:id,
          :price, :quantity, :shipment_id, :product_id, :productable_type,
          :productable_id, :_destroy])
    end
    
    def print
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Orden de venta N° #{@order_sale.order_sale_folio}",
          page_size: 'A4',
          template: "crm/sales_orders/print.html.slim",
          layout: "pdf.html",
          lowquality: true,
          zoom: 1,
          dpi: 75
        end
      end
    end

    private

    def search_by_client
      client_id = params[:c]
      @order_sales = @order_sales.where(client_id: client_id)
    end

    def search
      q = Regexp.escape(params[:q])
      
      @order_sales = @order_sales.where(
        'quote_folio ~* ? OR products.name ~* ? OR order_sale_folio ~* ?', q, q, q)
    end

    def set_object
      id = params[:id].present? ? params[:id] : params[:sales_order_id] 
      @order_sale = Shipment.find(id)
    end
  end
end