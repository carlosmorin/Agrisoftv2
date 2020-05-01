class FreightsController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy]
  add_breadcrumb "Fletes", :freights_path

  def index
  	@freights = Freight.paginate(page: params[:page], per_page: 20)
  	search if params[:q].present?
  end

	def edit
		add_breadcrumb "Editar"
	end
  
  def show
    add_breadcrumb "Detalle" 
  end

  private
  
  def search
    q = Regexp.escape(params[:q])
    
    @freights = @freights.where("concat(folio) ~* ?", q)
  end

  def set_object
  	@freight = Freight.find(params[:id])
  end
end