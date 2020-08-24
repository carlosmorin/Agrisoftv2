module Config
  module Production
    class ActivitiesController < ApplicationController
      before_action :find_activity, only: %i[show edit update destroy]
    
      add_breadcrumb "Produccion", :config_production_root_path
      add_breadcrumb "Actividades", :config_production_activities_path
      
      def index
        @index_facade = Activities::IndexFacade.new(params)
      end

      def new
        add_breadcrumb "Nuevo"
        @activity = Activity.new
      end

      def create
        @activity = Activity.new(activity_params)
        if @activity.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Actividad creada correctamente"
          redirect_to config_production_activity_url(@activity)
        else
          render :new
        end
      end

      def edit
        add_breadcrumb "Editar"
      end

      def show
        add_breadcrumb "Detalle de Aactividad"
      end

      def update
        if @activity.update(activity_params)
          flash[:notice] = "La Aactividad fue actualizada correctamente."
          redirect_to config_production_activity_url(@activity)
        else
          render :edit
        end
      end

      def destroy
        @activity.destroy
      end

      private

      def activity_params
        params.require(:activity).permit(:action, :production_unit)
      end

      def find_activity
        @activity = Activity.find(params[:id])
      end
    end
  end
end