# frozen_string_literal: true

module Config
  module Production
    class WeightUnitsController < ApplicationController
      before_action :find_weight_unit, only: %i[destroy]

      add_breadcrumb 'Produccion', :config_production_root_path
      add_breadcrumb 'Unidades de peso', :config_production_weight_units_path

      def index
        @index_facade = WeightUnits::IndexFacade.new(params)
        @weight_unit = WeightUnit.new
      end

      def create
        @weight_unit = WeightUnit.new(weight_units_params)
        if @weight_unit.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Unidad de peso creada correctamente"
          redirect_to config_production_weight_units_path
        else
          @index_facade = WeightUnit::IndexFacade.new(params)
          render :index
        end
      end

      def destroy
        @weight_unit.destroy
      end

      private

      def weight_units_params
        params.require(:weight_unit).permit(:name)
      end

      def find_weight_unit
        @weight_unit = WeightUnit.find(params[:id])
      end
    end
  end
end
