module Crm
  class SalesOrdersController < ApplicationController
  	before_action :set_object, only: %i[show edit update]
    before_action :set_catalogs, only: %i[edit update]

    add_breadcrumb "CRM", :crm_root_path
    add_breadcrumb "Ordenes de venta", :crm_sales_orders_path

    def index
    	@sales_orders = Shipment.order_sale.paginate(page: params[:page], per_page: 16)
      search if params[:q].present?
    end

    def edit
      add_breadcrumb "Editar"
    end

    def show
      add_breadcrumb "Detalle de orden de venta"
    end

    def update
      if @sales_order.update(client_params)
        flash[:notice] = "Orden de venta actualizada exitosamente"
        redirect_to crm_sales_order_url(@sales_order)
      else
        render :edit
      end
    end

    def destroy
      @sales_order.destroy
    end

    private

    def search
      q = Regexp.escape(params[:q])
      
      @sales_order = @sales_order.where("concat(folio, ' ', freight_folio, ' ', client_folio) ~* ?", q)
    end

    def set_object
      @sales_order = Shipment.find(params[:id])
    end
  end
end