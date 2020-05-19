module Logistic
  class UnitBrandsController < ApplicationController
		before_action :set_object, only: %i[edit update destroy]
    add_breadcrumb "Logistica", :logistic_root_path
    add_breadcrumb "Marcas de unidades", :logistic_unit_brands_path
  	
    def index
      @brands = UnitBrand.paginate(page: params[:page], per_page: 16)

      search if params[:q].present?
  	end

  	def new
  		add_breadcrumb "Nuevo"
			@brand = UnitBrand.new
		end

		def edit
  		add_breadcrumb "Editar"
		end

	  def create
	    @brand = UnitBrand.new(unit_brand_params)
      if @brand.save
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Marca creada correctamente"
        redirect_to logistic_unit_brands_url
      else
        render :new
      end
	  end

	  def update
    	if @brand.update(unit_brand_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Marca actualizada correctamente"
      	redirect_to logistic_unit_brands_url
    	else
      	render :edit
    	end
  	end

  	def destroy
    	@brand.destroy
  	end
	
	  private
    
    def search
      q = Regexp.escape(params[:q])
      @brands = @brands.where("concat(name, ' ', short_name) ~* ?", q)
    end

	  def unit_brand_params
			params.require(:unit_brand).permit(:name, :short_name)
	  end

	  def set_object
    	@brand = UnitBrand.find(params[:id])
  	end
  end
 end