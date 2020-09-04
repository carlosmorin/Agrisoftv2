module Config
  module Production
    class PerforationsController < ApplicationController
      before_action :find_perforation, only: %i[show edit update destroy]
      before_action :set_ranch, only: %i[new update]
    
      add_breadcrumb "Produccion", :config_production_root_path
      add_breadcrumb "Perforacions", :config_production_perforations_path
      
      def index
        @index_facade = Perforations::IndexFacade.new(params)
      end

      def new
        add_breadcrumb "Nuevo"
        @perforation = Perforation.new
      end

      def create
        @perforation = Perforation.new(perforation_params)
        @perforation.ranch_id = params[:ranch_id] if params[:ranch_id].present?
        if @perforation.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Perforacion creada correctamente"
          redirect_to config_production_perforation_url(@perforation)
        else
          render :new
        end
      end

      def edit
        add_breadcrumb "Editar"
      end

      def show
        add_breadcrumb "Detalle de la Perforacion"
      end

      def update
        if @perforation.update(perforation_params)
          flash[:notice] = "La perforacion fue actualizada correctamente."
          redirect_to config_production_perforation_url(@perforation)
        else
          render :edit
        end
      end

      def destroy
        @perforation.destroy
      end

      private

      def perforation_params
        params.require(:perforation).permit(:name, :coordinates, :registry_number, :volume, 
          :validity, :expenditure, :ranch_id, :perforation_structure, :document)
      end

      def find_perforation
        id = params[:id].present? ? params[:id] : params[:client_id] 
        @perforation = Perforation.find(id)
        @obj = @perforation
      end

      def set_ranch
        @ranch = Ranch.find(params[:ranch_id]) if params[:ranch_id]
      end
    end
  end
end