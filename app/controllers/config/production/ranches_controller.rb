module Config
  module Production
    class RanchesController < ApplicationController
      before_action :find_ranch, only: %i[show edit update destroy]
      before_action :set_catalogs, only: %i[edit update]
      
      add_breadcrumb "Produccion", :config_production_root_path
      add_breadcrumb "Ranchos", :config_production_ranches_path
      
      def index
        @index_facade = Ranches::IndexFacade.new(params)
      end

      def new
        add_breadcrumb "Nuevo"
        @ranch = Ranch.new
      end

      def create
        @ranch = Ranch.new(ranch_params)
        if @ranch.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Rancho creado correctamente"
          redirect_to config_production_ranch_url(@ranch)
        else
          render :new
        end
      end

      def edit
        add_breadcrumb "Editar"
      end

      def show
        add_breadcrumb "Detalle del Rancho"
      end

      def update
        if @ranch.update(ranch_params)
          flash[:notice] = "El rancho fue actualizado correctamente."
          redirect_to config_production_ranch_url(@ranch)
        else
          render :edit
        end
      end

      def destroy
        @ranch.destroy
      end

      private

      def ranch_params
        params.require(:ranch).permit(:state_id, :name, :municipality_id, :parcel_certificate, :manager_id, :territory, :hydrological_region,
        :aquifer_name, :georeference, :document)
      end

      def find_ranch
        @ranch = Ranch.find(params[:id])
      end

      def set_catalogs
        state = State.find(@ranch.state_id)
  
        @states = Country.find(1).states
        @municipalities = state.municipalities
      end
    end
  end
end