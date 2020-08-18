module Reports
  class ProductsController < ApplicationController
  	add_breadcrumb "Reportes"
  	add_breadcrumb "Productos"

  	def index
  		filter_crops if params[:crops].present?
  	end

  	private

  	def filter_crops
  		@crops = params[:crops][0].empty? ? Crop.all : Crop.find(params[:crops])
  	end
  end
end