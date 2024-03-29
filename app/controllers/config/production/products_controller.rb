# frozen_string_literal: true

module Config
  class Production::ProductsController < ApplicationController
    before_action :set_object, only: %i[edit update destroy show]

    add_breadcrumb 'Produccion', :config_production_root_path
    add_breadcrumb 'Productos', :config_production_products_path

    def index
      @products = Product.paginate(page: params[:page], per_page: 16)

      search_by_crop if params[:c].present?
      search_by_quality if params[:q].present?
      search_by_client_brand if params[:cb].present?
    end

    def new
      add_breadcrumb 'Nuevo'
      @product = Product.new
    end

    def edit
      add_breadcrumb 'Editar'
    end

    def show
      add_breadcrumb 'Detalle'
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        flash[:notice] = 'Producto creado exitosamente'
        redirect_to config_production_products_path
      else
        render :new
      end
    end

    def update
      if @product.update(product_params)
        flash[:notice] = 'Producto actualizado'
        redirect_to config_production_products_path
      else
        render :edit
      end
    end

    def destroy
      @product.destroy
    end

    private

    def search_by_crop
      crop_id = Regexp.escape(params[:c])
      @products = @products.where(crop_id: crop_id)
    end

    def search_by_quality
      quality_id = Regexp.escape(params[:q])
      @products = @products.where(quality_id: quality_id)
    end

    def search_by_client_brand
      ## cb = client_brand abrebation
      cb_id = Regexp.escape(params[:cb])
      @products = @products.where(client_brand_id: cb_id)
    end

    def product_params
      params.require(:product).permit(:crop_id, :color_id, :quality_id,
                                      :size_id, :package_id, :client_brand_id, :weight, :unit_meassure, :units_per_pallet)
    end

    def set_object
      @product = Product.find(params[:id])
    end

    def set_crop
      @crop = Crop.find(params[:crop_id])
    end
  end
end
