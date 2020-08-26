module Config
  module Production
    class StagesController < ApplicationController
      before_action :find_stage, only: %i[edit update destroy]
    
      add_breadcrumb "Produccion", :config_production_root_path
      add_breadcrumb "Etapas", :config_production_stages_path
      
      def index
        @index_facade = Stages::IndexFacade.new(params)
        @stage = Stage.new
      end

      def create
        @stage = Stage.new(stage_params)
        if @stage.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Etapa creada correctamente"
          redirect_to config_production_stages_path
        else
          @index_facade = Stages::IndexFacade.new(params)
          render :index
        end
      end

      def edit
        add_breadcrumb "Editar"
      end

      def update
        if @stage.update(stage_params)
          flash[:notice] = "La Etapa fue actualizada correctamente."
          redirect_to config_production_stages_path
        else
          render :edit
        end
      end

      def destroy
        @stage.destroy
      end

      private

      def stage_params
        params.require(:stage).permit(:name)
      end

      def find_stage
        @stage = Stage.find(params[:id])
      end
    end
  end
end