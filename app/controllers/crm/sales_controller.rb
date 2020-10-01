module Crm
	class SalesController < ApplicationController
		add_breadcrumb "CRM", :crm_root_path
		add_breadcrumb "Ventas", :crm_sales_path
		before_action :set_object, only: %i[show cancel set_contract expenses products]

		def index
			@sales = Shipment.sale.sales if params[:tab] == 'all'
			@sales = Shipment.sale.active_sales if params[:tab] == 'actived'
			@sales = Shipment.sale.canceled_sales if params[:tab] == 'canceled'

			@sales = @sales
								.order('folio DESC')
								.joins(products: [:crop, :color, :quality])
								.includes(products: [:crop, :color, :quality])	
								.paginate(page: params[:page], per_page: 25)
			@all_sales = Shipment.sale.all

			search if params[:q].present?
			search_by_client if params[:c].present?
			advanced_filters if params[:advanced].present? && params[:active_advanced]
		end

    def cancel
      @sale.update(cancel_sale: params[:cancel])
    end

    def set_contract
    	contract_id = params[:contract_id]
    	echange = params[:echange]

    	@sale.update(contract_id: contract_id, exchange_rate: echange) 
    end

    def show
    	add_breadcrumb "Gestion de venta"

    	@sale = @sale
    	@sale.shipments_products.new unless @sale.shipments_products.any?
			@sale.shipments_products.build.shipments_product_reports.build unless @sale.shipments_expenses.any?
    end

    def products
    	@sale.update(sale_params)
    end

    def expenses
    	@sale.update(sale_params)
    	render partial: 'crm/sales/show/collection_espenses', locals: { sale: @sale }
    end

		private

		def sale_params
			params.require(:shipment).permit(:client_id, :company_id, :contact_id,
        :user_id, :expirated_days, :expired_at, :status, :iva, :delivery_address_id,
        :issue_at, :discount, :currency, :exchange_rate, :description, 
        shipments_products_attributes: [:id, :price, :quantity, :shipment_id, 
        	:product_id, :productable_type, :productable_id, :_destroy],
        shipments_expenses_attributes: [:id, :expense_id, :unit, :total, :amount, 
        	:currency_id, :percentage, :_destroy]
      )
		end

		def advanced_filters
			search_by_crop if params[:advanced][:crop_id].present?
			search_by_quality if params[:advanced][:quality_id].present?
			search_by_package if params[:advanced][:package_id].present?
		end

		def search
			q = Regexp.escape(params[:q])

			@sales = @sales.where("folio ~* ? OR client_folio ~* ? OR freight_folio ~* ? ", q, q, q)

	  end

	  def search_by_crop
      crop_id = params[:advanced][:crop_id]
      @sales = @sales.where("products.crop_id = ?", crop_id)
    end

    def search_by_quality
      quality_id = params[:advanced][:quality_id]
      @sales = @sales.where("products.quality_id = ?", quality_id)
    end

    def search_by_package
      package_id = params[:advanced][:package_id]
      @sales = @sales.where("products.package_id = ?", package_id)
    end
		
		def search_by_client
			client_id = params[:c]
		  
			@sales = @sales.where(client_id: client_id)
		end

    def set_object
      id = params[:id].present? ? params[:id] : params[:sale_id]
      @sale = Shipment.find(id)
    end
  end
end