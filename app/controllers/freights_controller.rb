class FreightsController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy]
  add_breadcrumb "Fletes", :freights_path

  def index
    @freights = Freight.paginate(page: params[:page], per_page: 20)
    
    search if params[:q].present?
  end

  def edit
    add_breadcrumb "Editar"
    iva_id = Tax.find_by_name("iva").id
    @freight.freights_taxes.build(tax_id: iva_id)
	end
  
  def show
    add_breadcrumb "Detalle" 
  end

  private
  
  def search
    q = Regexp.escape(params[:q])
    
    @freights = @freights.where("concat(folio) ~* ?", q)
  end

  def driver_params
    params.require(:freight).permit(
      :carrier_id, :driver_id, :unit_id, :box_id, :folio, :pay_client, 
      :pay_company, :cost, :invoice_serie, :invoice_total, :pdf_invoice, 
      :xml_invoice, freights_taxes_attributes: [:freight_id, :tax_id, :value])
  end

  def set_object
    @freight = Freight.find(params[:id])
  end
end