module Config
  class UnitBrandsController < ApplicationController
		before_action :set_object, only: %i[edit update destroy]
  	add_breadcrumb "Config"
  	add_breadcrumb "Marcas unidades", :config_unit_brands_path
  	
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
	    respond_to do |format|
	      if @brand.save
	        format.html { redirect_to config_unit_brands_url, notice: 'Marca creada.' }
	      else
	        format.html { render :new }
	      end
	    end
	  end

	  def update
    	if @brand.update(unit_brand_params)
      	flash[:notice] = "Marca #{@brand.name} actualizada"
      	redirect_to config_unit_brands_url
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