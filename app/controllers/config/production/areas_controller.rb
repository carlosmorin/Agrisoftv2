module Config
  module Production
    class AreasController < ApplicationController
      before_action :find_area, only: %i[show edit update destroy]
      before_action :set_ranch, only: %i[new update]
    
      add_breadcrumb "Produccion", :config_production_root_path
      add_breadcrumb "Areas", :config_production_areas_path
      
      def index
        @index_facade = Areas::IndexFacade.new(params)
      end

      def new
        add_breadcrumb "Nuevo"
        @area = Area.new
      end

      def create
        @area = Area.new(area_params)
        @area.ranch_id = params[:ranch_id] if params[:ranch_id].present?
        if @area.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Area creada correctamente"
          redirect_to config_production_area_url(@area)
        else
          render :new
        end
      end

      def edit
        add_breadcrumb "Editar"
      end

      def show
        add_breadcrumb "Detalle de Area"
      end

      def update
        if @area.update(area_params)
          flash[:notice] = "La Area fue actualizada correctamente."
          redirect_to config_production_area_url(@area)
        else
          render :edit
        end
      end

      def destroy
        @area.destroy
      end

      private

      def area_params
        params.require(:area).permit(:name, :territory, :type_of_irrigation, :ranch_id)
      end

      def find_area
        id = params[:id].present? ? params[:id] : params[:client_id] 
        @area = Area.find(id)
      end

      def set_ranch
        @ranch = Ranch.find(params[:ranch_id]) if params[:ranch_id]
      end
    end
  end
end