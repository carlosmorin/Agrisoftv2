module Crm
	class SalesController < ApplicationController
		add_breadcrumb "CRM", :crm_root_path
		before_action :set_object, only: %i[show cancel set_contract update_currency update_products 
      update_expenses update_reports update_documents to_collect manage]

		def index
      add_breadcrumb "Ventas", crm_sales_path(tab: :all)
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

    	@sale.update(contract_id: contract_id)
      remove_expenses
      build_expenses(contract_id)
    end

    def update_currency
      currency_id = params[:currency_id]
      exchange_rate = params[:exchange_rate]
      @sale.update(currency_id: currency_id, exchange_rate: exchange_rate)
    end

    def show
      add_breadcrumb "Ventas", crm_sales_path(tab: :all)
    	add_breadcrumb "Gestion de venta"
      @report = ShipmentsProductReport.new
    	@sale = @sale
      @total_mxn_expenses = 0

      if params[:format].present?
        respond_to do |format|
          format.html
          format.xlsx
        end
      end
    end

    def manage
      add_breadcrumb "Ventas", crm_sales_path(tab: :all)
      add_breadcrumb "Gestionar venta"
      @expense = ShipmentsExpense.new
      @bills = @sale.bills.order(:created_at)
    end

    def update_products
    	@sale.update(sale_params)
      render partial: 'crm/sales/show/collection_products', locals: { sale: @sale }
    end

    def update_expenses
      @sale.update(sale_params)
    end

    def update_documents
      @sale.documents.attach(params[:documents])
      render partial: 'crm/sales/show/files_collection', locals: { sale: @sale }
    end

    def to_collect
      @sale.update(to_collect_at: Time.zone.now)
    end

    def get_report_products
      @product = ShipmentsProduct.find(params[:sp_id])
    end

    private

		def sale_params
			params.require(:shipment).permit(:id, :client_id, :company_id, :contact_id,
        :user_id, :expirated_days, :expired_at, :status, :iva, :delivery_address_id,
        :issue_at, :discount, :currency, :exchange_rate, :description, documents: [],
        shipments_products_attributes: [:id, :price, :quantity, :shipment_id, 
        	:product_id, :productable_type, :productable_id, :_destroy, 
          shipments_product_reports_attributes: [ :id, :shipments_product_id, :quantity, :price, :currency_id, :_destroy]],
        shipments_expenses_attributes: [:id, :expense_id, :unit, :total, :type_expense, :amount, 
        	:currency_id, :percentage, :_destroy, :type_expense]
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

    def remove_expenses
      @sale.shipments_expenses.expense_type.destroy_all
    end

    def build_expenses(contact_id)
      contract = Contract.find(contact_id)
      expenses = contract.contracts_expenses
      params = build_expenses_params(expenses)
      @sale.shipments_expenses.build(params)
      @sale.save
    end

    def build_expenses_params(expenses)
      params = []
      expenses.each do |expense|
        params << {
          shipment_id: @sale.id,
          expense_id: expense.expense_id,
          currency_id: expense.currency_id,
          amount: expense.price,
          unit: expense.unit_sale,
          percentage: expense.percentage,
          type_expense: 'expense_type'
        }
      end
      params
    end
  end
end