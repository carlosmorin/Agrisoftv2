module Config
  module Production
    class IrrigationTypesController < ApplicationController
      before_action :find_irrigation_type, only: %i[destroy]
    
      add_breadcrumb "Produccion", :config_production_root_path
      add_breadcrumb "Tipos de Irrigacion", :config_production_irrigation_types_path
      
      def index
        @index_facade = IrrigationTypes::IndexFacade.new(params)
        @irrigation_type = IrrigationType.new
      end

      def create
        @irrigation_type = IrrigationType.new(irrigation_types_params)
        if @irrigation_type.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Tipo de riego creado correctamente"
          redirect_to config_production_irrigation_types_path
        else
          @index_facade = IrrigationTypes::IndexFacade.new(params)
          render :index
        end
      end

      def destroy
        @irrigation_type.destroy
      end

      private

      def irrigation_types_params
        params.require(:irrigation_type).permit(:name)
      end

      def find_irrigation_type
        @irrigation_type = IrrigationType.find(params[:id])
      end
    end
  end
end