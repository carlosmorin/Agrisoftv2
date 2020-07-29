module Logistic
  module Config
    class BoxTypesController < ApplicationController
      before_action :set_object, only: %i[edit update destroy]
  		add_breadcrumb "Logistica", :logistic_root_path
      add_breadcrumb "Configuración", :logistic_config_root_path
      add_breadcrumb "Tipos de Cajas", :logistic_config_box_types_path

      def index
        @boxes = BoxType.paginate(page: params[:page], per_page: 16)

        search if params[:q].present?
      end

    	def new
    		add_breadcrumb "Nueva"
  			@box = BoxType.new
  		end

  		def edit
  			add_breadcrumb "Editar"
  		end

  	  def create
  	    @box = BoxType.new(box_types_params)
        if @box.save
        	flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Tipo de Caja creada correctamente"
          redirect_to logistic_box_types_path
        else
          render :new
        end
  	  end

  	  def update
      	if @box.update(box_types_params)
        	flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Tipo Caja actualizada correctamente"
        	redirect_to logistic_box_types_url
      	else
        	render :edit
      	end
    	end

    	def destroy
      	@box.destroy
    	end
  	
  	  private

  	  def search
        q = Regexp.escape(params[:q])
        @boxes = @boxes.where("name ~* ?", q)
      end

  	  def box_types_params
  			params.require(:box_type).permit(:name)
  	  end

  	  def set_object
      	@box = BoxType.find(params[:id])
    	end
    end
  end
 end