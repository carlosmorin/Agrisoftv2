# frozen_string_literal: true

module Logistic
  class FreightsController < ApplicationController
    before_action :set_object, only: %i[show edit update destroy]
    add_breadcrumb 'Logistica', :logistic_root_path
    add_breadcrumb 'Fletes', :logistic_freights_path

    def index
      @freights = Freight.paginate(page: params[:page], per_page: 25)

      search if params[:q].present?
      search_by_carrier if params[:carrier_id].present?
      search_by_dates if params[:dates].present?
    end

    def edit
      if params[:carrier_id].present?
        add_breadcrumb 'Transportistas', logistic_carriers_path
      end
      if params[:carrier_id].present?
        add_breadcrumb @freight.carrier.name.upcase, logistic_carrier_path(@freight.carrier, tab: :general)
      end
      add_breadcrumb @freight.folio.to_s, logistic_carrier_freight_path(@freight.carrier, @freight)
      add_breadcrumb 'Editar'

      @freight.freights_taxes.build if @freight.freights_taxes.empty?
    end

    def update
      if @freight.update(frieght_params)
        flash[:notice] = "<i class='fa fa-check-circle s-16 mr-2'></i>Felete <b>#{@freight.folio.upcase}</b> actualizado
          exitosamente"
        redirect_to logistic_carrier_freight_path(@freight.carrier, @freight)
      else
        render :edit
      end
    end

    def show
      add_breadcrumb @freight.folio.to_s unless params[:carrier_id]
      if params[:carrier_id]
        add_breadcrumb 'Transportistas', logistic_carriers_path
      end
      if params[:carrier_id]
        add_breadcrumb @freight.carrier.name.upcase, logistic_carrier_path(@freight.carrier, tab: :general)
      end
      if params[:carrier_id]
        add_breadcrumb 'Fletes', logistic_carrier_path(@freight.carrier, tab: :freights)
      end
      if params[:carrier_id]
        add_breadcrumb @freight.folio.to_s, logistic_carrier_freight_path(@freight.carrier, @freight)
      end
    end

    private

    def search
      q = Regexp.escape(params[:q])

      @freights = @freights.where('concat(folio) ~* ?', q)
    end

    def search_by_carrier
      carrier_id = Regexp.escape(params[:carrier_id])

      @freights = @freights.where('carrier_id = ?', carrier_id)
    end

    def search_by_dates
      dates = params[:dates].split(' to ')
      from = Date.parse(dates.first).beginning_of_day
      to = Date.parse(dates.second).end_of_day

      @freights = @freights.where(created_at: from..to)
    end

    def frieght_params
      params.require(:freight).permit(
        :carrier_id, :driver_id, :unit_id, :box_id, :folio, :pay_client,
        :pay_company, :cost, :invoice_serie, :invoice_total, :pdf_invoice,
        :xml_invoice, freights_taxes_attributes: %i[id freight_id tax_id value _destroy]
      )
    end

    def set_object
      @freight = Freight.find(params[:id])
    end
  end
end
