# frozen_string_literal: true

module Logistic
  module Config
    class BoxTypesController < ApplicationController
      include Breadcrumbs::Logistic::Config::BoxTypes
      before_action :set_object, only: %i[edit update destroy]
      before_action :build_breadcrumbs, only: %i[new edit update create]

      def index
        @boxes = BoxType.paginate(page: params[:page], per_page: 25)

        search if params[:q].present?
      end

      def new
        @box = BoxType.new
      end

      def edit; end

      def create
        @box = BoxType.new(box_types_params)
        if @box.save
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-12'></i> Nuevo tipo de caja creada correctamente"
          redirect_to logistic_config_box_types_path
        else
          render :new
        end
      end

      def update
        if @box.update(box_types_params)
          flash[:notice] = "<i class='fa fa-check-circle mr-1 s-12'></i> Tipo Caja actualizada correctamente"
          redirect_to logistic_config_box_types_url
        else
          render :edit
        end
      end

      def destroy
        @box.destroy
      end

      private

      def search
        q = Regexp.escape(params[:q])
        @boxes = @boxes.where('name ~* ?', q)
      end

      def box_types_params
        params.require(:box_type).permit(:name)
      end

      def set_object
        @box = BoxType.find(params[:id])
      end
    end
  end
 end
