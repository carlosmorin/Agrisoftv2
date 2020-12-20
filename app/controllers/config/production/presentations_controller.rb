# frozen_string_literal: true

module Config
  module Production
    class PresentationsController < ApplicationController
      before_action :find_presentation, only: %i[show edit update destroy]
      # before_action :set_ranch, only: %i[new update]

      add_breadcrumb 'Produccion', :config_production_root_path
      add_breadcrumb 'Presentaciones', :config_production_presentations_path

      def index
        @index_facade = Presentations::IndexFacade.new(params)
      end

      def new
        add_breadcrumb 'Nuevo'
        @presentation = Presentation.new
      end

      def create
        @presentation = Presentation.new(presentation_params)
        # @presentation.supply_id = params[:supply_id] if params[:supply_id].present?
        if @presentation.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Presentacion creada correctamente"
          redirect_to new_config_production_presentation_path
        else
          render :new
        end
      end

      def edit
        add_breadcrumb 'Editar'
      end

      def show
        add_breadcrumb 'Detalle de la Presentacion'
      end

      def update
        if params[:supply_id].present?
          @presentation.update!(presentation_params)
          @presentation_supply.update!(presentation_supply_params)
          flash[:notice] = 'La Presentacion fue actualizada correctamente.'
          return redirect_to config_production_supply_url(@supply.id, tab: :presentations)
        end
        @presentation.update!(presentation_params)
        flash[:notice] = 'La Presentacion fue actualizada correctamente.'
        redirect_to config_production_presentation_url(@presentation, tab: :supplies)
      rescue ActiveRecord::RecordInvalid
        render :edit
      end

      def destroy
        @presentation.destroy
      end

      private

      def presentation_params
        params.require(:presentation).permit(:name, :quantity, :weight_unit_id, :supply_id,
                                             presentation_supplies_attributes: %i[id presentation_id supply_id price price_to_credit _destroy])
      end

      def presentation_supply_params
        params.require(:presentation).require(:presentation_supply).permit(:price, :price_to_credit)
      end

      def find_presentation
        if params[:supply_id].present?
          @supply = Supply.find(params[:supply_id])
          @presentation_supply = PresentationSupply.where(supply_id: params[:supply_id], presentation_id: params[:id]).first
        end
        @presentation = Presentation.find(params[:id])
        @obj = @presentation
      end

      # pending until i have the supply model
      # def set_ranch
      #   @ranch = Ranch.find(params[:ranch_id]) if params[:ranch_id]
      # end
    end
  end
end
