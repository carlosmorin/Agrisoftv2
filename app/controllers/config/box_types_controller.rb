module Config
  class BoxTypesController < ApplicationController
		before_action :set_object, only: %i[edit update destroy]
  	
  	def index
  		@boxes = BoxType.all
  	end

  	def new
			@box = BoxType.new
		end

	  def create
	    @box = BoxType.new(box_types_params)
	    respond_to do |format|
	      if @box.save
	        format.html { redirect_to config_box_types_url, notice: 'Caja creada.' }
	      else
	        format.html { render :new }
	      end
	    end
	  end

	  def update
    	if @box.update(box_types_params)
      	flash[:notice] = "Caja #{@box.name} actualizada"
      	redirect_to config_box_types_url
    	else
      	render :edit
    	end
  	end

  	def destroy
    	@box.destroy
  	end
	
	  private

	  def box_types_params
			params.require(:box_type).permit(:name)
	  end

	  def set_object
    	@box = BoxType.find(params[:id])
  	end
  end
 end