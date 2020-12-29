# frozen_string_literal: true

module Config
  module Production
    class CategoriesController < ApplicationController
      before_action :find_category, only: %i[destroy edit update]

      add_breadcrumb 'Produccion', :config_production_root_path
      add_breadcrumb 'Categorias', :config_production_categories_path

      def index
        @index_facade = Categories::IndexFacade.new(params)
        @category = Category.new
      end

      def create
        @category = Category.new(categories_params)
        if @category.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Categoria creada correctamente"
          redirect_to config_production_categories_path
        else
          @index_facade = Categories::IndexFacade.new(params)
          render :index
        end
      end

      def edit
        add_breadcrumb 'Editar'
      end

      def update
        if @category.update(categories_params)
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i>  Categoria actualizada correctamente"
          redirect_to config_production_categories_path
        else
          render :edit
        end
      end

      def destroy
        @category.destroy
      end

      def get_supplies_codes
        category = Category.find(params[:id])
        render json: { codes: category.supplies.pluck(:code).uniq.compact, category: category.name }
      end

      private

      def categories_params
        params.require(:category).permit(:name)
      end

      def find_category
        @category = Category.find(params[:id])
      end
    end
  end
end
