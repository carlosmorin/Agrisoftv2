# frozen_string_literal: true

module Config
  module Production
    class ProductionUnitsController < ApplicationController
      before_action :find_production_unit, only: %i[destroy edit update]
      before_action :initialize_facade, only: %i[create index]

      add_breadcrumb 'Produccion', :config_production_root_path
      add_breadcrumb 'Unidades de Produccion', :config_production_production_units_path

      def index
        @production_unit = ProductionUnit.new
      end

      def edit
        add_breadcrumb 'Editar'
      end

      def update
        if @production_unit.update(production_units_params)
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Unidad de produccion actualizada correctamente"
          redirect_to config_production_production_units_path
        else
          render :edit
        end
      end

      def create
        @production_unit = ProductionUnit.new(production_units_params)
        if @production_unit.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Unidad de produccion creada correctamente"
          redirect_to config_production_production_units_path
        else
          render :index
        end
      end

      def destroy
        @production_unit.destroy
      end

      private

      def production_units_params
        params.require(:production_unit).permit(:name, :weight, :weight_unit_id)
      end

      def find_production_unit
        @production_unit = ProductionUnit.find(params[:id])
      end

      def initialize_facade
        @index_facade = ProductionUnits::IndexFacade.new(params)
      end
    end
  end
end
