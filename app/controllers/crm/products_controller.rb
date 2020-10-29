module Crm
	class ProductsController < ApplicationController
  	before_action :set_object, only: %i[edit update]

		def edit
		end

		def update
			@product.update(product_params)
		end

    def product_params
      params.require(:shipments_product).permit( :id, :shipment_id, :product_id, 
      	:price, :quantity)
    end

    private

		def set_object
			id = params[:id]
			@product = ShipmentsProduct.find(id)
		end
	end
end
