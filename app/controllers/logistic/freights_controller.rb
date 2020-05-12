module Logistic
  class FreightsController < ApplicationController
    before_action :set_object, only: %i[show edit update destroy]
    add_breadcrumb "Fletes", :logistic_freights_path

    def index
      @freights = Freight.paginate(page: params[:page], per_page: 20)
      
      search if params[:q].present?
    end

    def edit
      add_breadcrumb "Editar"
      if @freight.freights_taxes.empty?
        @freight.freights_taxes.build
      end
    end

    def update
      if @freight.update(frieght_params)
        flash[:notice] = "Felete <b>#{@freight.folio.upcase}</b> actualizado
          exitosamente"
        redirect_to freight_url(@freight)
      else
        render :edit
      end
    end
    
    def show
      add_breadcrumb "Detalle" 
    end

    private
    
    def search
      q = Regexp.escape(params[:q])
      
      @freights = @freights.where("concat(folio) ~* ?", q)
    end

    def frieght_params
      params.require(:freight).permit(
        :carrier_id, :driver_id, :unit_id, :box_id, :folio, :pay_client, 
        :pay_company, :cost, :invoice_serie, :invoice_total, :pdf_invoice, 
        :xml_invoice, freights_taxes_attributes: [:id, :freight_id, :tax_id, :value, :_destroy])
    end

    def set_object
      @freight = Freight.find(params[:id])
    end
  end
end