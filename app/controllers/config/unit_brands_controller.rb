module Config
  class UnitBrandsController < ApplicationController
		before_action :set_object, only: %i[edit update destroy]
  	
  	def index
  		@brands = UnitBrand.all
  	end

  	def new
			@brand = UnitBrand.new
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

	  def unit_brand_params
			params.require(:unit_brand).permit(:name, :short_name)
	  end

	  def set_object
    	@brand = UnitBrand.find(params[:id])
  	end
  end
 end