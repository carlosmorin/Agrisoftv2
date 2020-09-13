module Crm
  class SalesOrdersController < ApplicationController
  	before_action :set_object, only: %i[show edit update print print_aditional_data cancel]

    add_breadcrumb "CRM", :crm_root_path

    def index
      add_breadcrumb "Ordenes de venta", crm_sales_orders_path(tab: :all)
    	@order_sales = Shipment.order_sales if params[:tab] == 'all'
      @order_sales = Shipment.canceled_order_sales if params[:tab] == 'canceled'
      @order_sales = Shipment.left_outer_joins(:appointments).active_order_sales if params[:tab] == 'actives'
      @order_sales = Shipment.joins(:appointments).expirated_order_sales if params[:tab] == 'expirated'

      @order_sales = @order_sales.order('order_sale_folio DESC')
                      .joins(products: [:crop, :color, :quality])
                      .includes(products: [:crop, :color, :quality])
                      .paginate(page: params[:page], per_page: 25)
      @quotes = Shipment.quotation
      search if params[:q].present?
      search_by_client if params[:c].present?
      advanced_filters if params[:advanced].present? && params[:active_advanced]
    end

    def new 
      add_breadcrumb "Ordenes de venta", crm_sales_orders_path(tab: :all)
      add_breadcrumb "Nueva"
      @order_sale = Shipment.new(status: :order_sale)
      @order_sale.shipments_products.build
      @order_sale.appointments.build
    end

    def edit
      add_breadcrumb "Ordenes de venta", crm_sales_orders_path(tab: :all)
      add_breadcrumb "Editar"
      if @order_sale.appointments.any?
        started_at = @order_sale.appointments.first.started_at&.strftime('%d-%m-%Y')
        finished_at = @order_sale.appointments.first.finished_at&.strftime('%d-%m-%Y')
        started_at = "#{started_at} to #{finished_at}"
        @order_sale.appointments.first.started_at = started_at
      else
        @order_sale.appointments.build
      end
    end

    def show
      add_breadcrumb "Ordenes de venta", crm_sales_orders_path(tab: :all)
      add_breadcrumb "Detalle de orden de venta"
    end

    def create
      @order_sale = Shipment.new(order_sale_params)
      @order_sale.status = :order_sale if @order_sale.status != :order_sale
      if @order_sale.save
        flash[:notice] = "<i class='fa fa-check-circle mr-2'></i> Orden de venta creada exitosamente"
        redirect_to crm_sales_order_path(@order_sale)
      else
        started_at = params[:shipment][:appointments_attributes]["0"][:started_at]
        @order_sale.appointments.first.started_at = started_at
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

    def cancel
      binding.pry
      @order_sale.update(cancel_sale: params[:cancel])
    end

    def order_sale_params
      params.require(:shipment).permit(:client_id, :company_id, :contact_id,
        :user_id, :expirated_days, :expired_at, :status, :iva, :delivery_address_id,
        :issue_at, :discount, :currency, :exchange_rate, :description, 
          shipments_products_attributes: [:id, :price, :quantity, :shipment_id, :product_id, :productable_type, :productable_id, :_destroy],
          appointments_attributes: [:id, :n_request, :started_at, :finished_at, :appointment_at, :commitment_at, :appointment_number, :comments]
      )
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
    
    def print_aditional_data
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Inf adicional #{@order_sale.order_sale_folio}",
          page_size: 'A4',
          template: "crm/sales_orders/print_aditional_data.html.slim",
          layout: "pdf.html",
          lowquality: true,
          zoom: 1,
          dpi: 75
        end
      end
    end

    private

    def advanced_filters
      search_by_crop if params[:advanced][:crop_id].present?
      search_by_quality if params[:advanced][:quality_id].present?
      search_by_package if params[:advanced][:package_id].present?
    end

    def search_by_client
      client_id = params[:c]
      @order_sales = @order_sales.where(client_id: client_id)
    end

    def search_by_crop
      crop_id = params[:advanced][:crop_id]
      @order_sales = @order_sales.where("products.crop_id = ?", crop_id)
    end

    def search_by_quality
      quality_id = params[:advanced][:quality_id]
      @order_sales = @order_sales.where("products.quality_id = ?", quality_id)
    end

    def search_by_package
      package_id = params[:advanced][:package_id]
      @order_sales = @order_sales.where("products.package_id = ?", package_id)
    end

    def search
      q = Regexp.escape(params[:q])
      
      @order_sales = @order_sales.where(
        " order_sale_folio ~* ?", q)
    end

    def set_object
      id = params[:id].present? ? params[:id] : params[:sales_order_id] 
      @order_sale = Shipment.find(id)
    end
  end
end