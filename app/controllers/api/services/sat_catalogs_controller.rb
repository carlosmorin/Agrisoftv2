module Api::Services
  class SatCatalogsController < ApplicationController
    def index
      return unless params[:query].length > 3

      search_products_and_services if params[:catalog].eql?('products')
      search_units if params[:catalog].eql?('units')
    end

    private

    def search_products_and_services
      @products = SatProduct.all

      q = Regexp.escape(params[:query])
      @products = @products.where("concat(key,' ', name) ~* ?", q)

      render json: @products
    end

    def search_units
      @units = SatUnitMeasure.all

      q = Regexp.escape(params[:query])
      @units = @units.where("concat(key,' ', name) ~* ?", q)

      render json: @units
    end
  end
end