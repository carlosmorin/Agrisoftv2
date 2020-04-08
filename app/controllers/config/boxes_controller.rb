module Config
  class BoxesController < ApplicationController
		before_action :set_object, only: %i[show edit update destroy]
  	before_action :set_catalogs, except: %i[show]
    add_breadcrumb "Config"
  	add_breadcrumb "Cajas", :config_boxes_path

  	def index
  		@boxes = Box.paginate(page: params[:page], per_page: 18) 
			search if params[:q].present?
			search_by_carrier if params[:c].present?
			search_by_box_type if params[:b_t].present?
  	end

		def new
	    add_breadcrumb "Nuevo"
	    @box = Box.new
		end

	  def edit
	    add_breadcrumb "Editar"
	  end

	  def show
	    add_breadcrumb "Detalle"
	  end

	  def create
	    @box = Box.new(box_params)
      if @box.save
        redirect_to config_boxes_url, notice: 'Caja creada'
      else
        render :new, carriers: @carriers, box_types: @box_types
      end
	  end

		def update
    	if @box.update(box_params)
      	flash[:notice] = "Caja actualizada"
      	redirect_to config_boxes_url
    	else
      	render :edit, carriers: @carriers, box_types: @box_types
    	end
  	end
  	
  	def destroy
    	@box.destroy
  	end

	  private

		def search
	    s = Regexp.escape(params[:q])
	    
	    @boxes = @boxes.where("concat(plate_number, ' ', n_econ) ~* ?", s)
	  end

	  def search_by_carrier
      c = Regexp.escape(params[:c])

      @boxes = @boxes.where(carrier_id: c)
    end

    def search_by_box_type
      b_t = Regexp.escape(params[:b_t])

      @boxes = @boxes.where(box_type_id: b_t)
    end

		def box_params
    	params.require(:box).permit(
    		:temperature, :plate_number, :n_econ, :carrier_id, :box_type_id)
  	end

  	def set_object
			@box = Box.find(params[:id])
  	end

	  def set_catalogs
	  	@carriers = Carrier.all.pluck(:name, :id)
	  	@box_types = BoxType.all.pluck(:name, :id)
	  end
  end
end