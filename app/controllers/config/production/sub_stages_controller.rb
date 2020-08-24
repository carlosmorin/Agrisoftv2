module Config
  module Production
    class SubStagesController < ApplicationController
      before_action :find_sub_stage, only: %i[show edit update destroy]
    
      add_breadcrumb "Produccion", :config_production_root_path
      add_breadcrumb "Sub Etapas", :config_production_sub_stages_path
      
      def index
        @index_facade = SubStages::IndexFacade.new(params)
      end

      def new
        add_breadcrumb "Nuevo"
        @sub_stage = SubStage.new
      end

      def create
        @sub_stage = SubStage.new(sub_stage_params)
        if @sub_stage.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Sub Etapa creada correctamente"
          redirect_to config_production_sub_stage_url(@sub_stage)
        else
          render :new
        end
      end

      def edit
        add_breadcrumb "Editar"
      end

      def show
        add_breadcrumb "Detalle de Sub Etapa"
      end

      def update
        if @sub_stage.update(sub_stage_params)
          flash[:notice] = "La Sub Etapa fue actualizada correctamente."
          redirect_to config_production_sub_stage_url(@sub_stage)
        else
          render :edit
        end
      end

      def destroy
        @sub_stage.destroy
      end

      private

      def sub_stage_params
        params.require(:sub_stage).permit(:name)
      end

      def find_sub_stage
        @sub_stage = SubStage.find(params[:id])
      end
    end
  end
end