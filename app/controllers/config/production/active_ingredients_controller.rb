module Config
  module Production
    class ActiveIngredientsController < ApplicationController
      before_action :find_active_ingredient, only: %i[destroy edit update show]
    
      add_breadcrumb "Produccion", :config_production_root_path
      add_breadcrumb "Ingredientes Activos", :config_production_active_ingredients_path
      
      def index
        @index_facade = ActiveIngredients::IndexFacade.new(params)
        @active_ingredient = ActiveIngredient.new
      end

      def create
        @active_ingredient = ActiveIngredient.new(active_ingredients_params)
        if @active_ingredient.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Ingrediente activo creado correctamente"
          redirect_to config_production_active_ingredients_path
        else
          @index_facade = ActiveIngredients::IndexFacade.new(params)
          render :index
        end
      end

      def edit
        add_breadcrumb "Editar"
      end

      def show
        add_breadcrumb "Detalle"   
      end

      def update
        if params[:supply_id].present?
          @active_ingredient.update!(active_ingredients_params)
          # binding.pry
          @active_ingredient_supply.update!(active_ingredient_supply_params)
          # binding.pry
          flash[:notice] = "El Ingrediente activo fue actualizado correctamente."
          return redirect_to config_production_supply_url(@supply.id, tab: :active_ingredients)
        end
        @active_ingredient.update!(active_ingredients_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Ingrediente activo actualizado correctamente"
        redirect_to config_production_active_ingredients_path
      rescue ActiveRecord::RecordInvalid
        render :edit
      end

      def destroy
        @active_ingredient.destroy
      end

      private

      def active_ingredients_params
        params.require(:active_ingredient).permit(:name,
        active_ingredient_supplies_attributes: [:id, :supply_id, :active_ingredient_id, :_destroy])
      end

      def active_ingredient_supply_params
        params.require(:active_ingredient).require(:active_ingredient_supply).permit(:percentage)
      end

      def find_active_ingredient
        if params[:supply_id].present?
          @supply = Supply.find(params[:supply_id]) 
          @active_ingredient_supply = ActiveIngredientSupply.where(supply_id: params[:supply_id], active_ingredient_id: params[:id]).first
        end
        @active_ingredient = ActiveIngredient.find(params[:id])
      end
    end
  end
end