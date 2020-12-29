# frozen_string_literal: true

module Crm
  class QuotesController < ApplicationController
    before_action :set_object, only: %i[show print edit update update_status cancel]
    add_breadcrumb 'CRM', :crm_root_path

    def index
      add_breadcrumb 'Cotizaciónes', crm_quotes_path(tab: :all)

      @quotes = Shipment.quotes if params[:tab] == 'all'
      @quotes = Shipment.quotes.active_quotes if params[:tab] == 'actives'
      @quotes = Shipment.quotes.expirated_quotes if params[:tab] == 'expirated'
      @quotes = Shipment.quotes.canceled_quotes if params[:tab] == 'canceled'

      @quotes = @quotes.order(quote_folio: :desc)
                       .joins(:products)
                       .joins(products: %i[crop color quality])
                       .includes(products: %i[crop color quality])
                       .paginate(page: params[:page], per_page: 25)
      search if params[:q].present?
      search_by_client if params[:c].present?
      advanced_filters if params[:advanced].present? && params[:active_advanced]
    end

    def show
      add_breadcrumb 'Cotizaciónes', crm_quotes_path(tab: :all)
      add_breadcrumb 'Detalle'

      if params[:format].present?
        respond_to do |format|
          format.html
          format.xlsx
        end
      end
    end

    def new
      add_breadcrumb 'Cotizaciónes', crm_quotes_path(tab: :all)
      add_breadcrumb 'Nueva'
      @quote = Shipment.new
      @quote.shipments_products.build
    end

    def edit
      add_breadcrumb 'Cotizaciónes', crm_quotes_path(tab: :all)
      add_breadcrumb 'Editar'
    end

    def consolidate
      add_breadcrumb 'Consolidar'
    end

    def create
      @quote = Shipment.new(quote_params)
      @quote.status = :quotation

      if @quote.save
        flash[:notice] = "<i class='fa fa-check-circle mr-2'></i> Cotización creada exitosamente"
        redirect_to crm_quote_path(@quote)
      else
        render :new
      end
    end

    def update
      if @quote.update(quote_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-2'></i> Cotización actualizada exitosamente"
        redirect_to crm_quote_path(@quote)
      else
        render :edit
      end
    end

    def update_status
      @quote.status = params[:status]
      @quote.save!
    end

    def cancel
      @quote.update(cancel_quote: params[:cancel])
    end

    def print
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Cotización N° #{@quote.folio}",
                 page_size: 'A4',
                 template: 'crm/quotes/print.html.slim',
                 layout: 'pdf.html',
                 lowquality: true,
                 zoom: 1,
                 dpi: 75
        end
      end
    end

    def quote_params
      params.require(:shipment).permit(:client_id, :company_id, :contact_id,
                                       :user_id, :expirated_days, :expired_at, :status, :iva, :delivery_address_id,
                                       :issue_at, :discount, :currency_id, :exchange_rate, :description, shipments_products_attributes: %i[id
                                                                                                                                           price quantity shipment_id product_id productable_type
                                                                                                                                           productable_id _destroy])
    end

    private

    def advanced_filters
      search_by_crop if params[:advanced][:crop_id].present?
      search_by_quality if params[:advanced][:quality_id].present?
      search_by_package if params[:advanced][:package_id].present?
    end

    def search_by_client
      client_id = params[:c]
      @quotes = @quotes.where(client_id: client_id)
    end

    def search_by_crop
      crop_id = params[:advanced][:crop_id]
      @quotes = @quotes.where('products.crop_id = ?', crop_id)
    end

    def search_by_quality
      quality_id = params[:advanced][:quality_id]
      @quotes = @quotes.where('products.quality_id = ?', quality_id)
    end

    def search_by_package
      package_id = params[:advanced][:package_id]
      @quotes = @quotes.where('products.package_id = ?', package_id)
    end

    def search
      q = Regexp.escape(params[:q])

      @quotes = @quotes.where('quote_folio ~* ?', q)
    end

    def set_object
      id = params[:id].present? ? params[:id] : params[:quote_id]
      @quote = Shipment.find(id)
    end
  end
end
