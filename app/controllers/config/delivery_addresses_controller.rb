module Config
	class DeliveryAddressesController < ApplicationController
  	add_breadcrumb "Config"
    add_breadcrumb "Direcciónes de entrega", :config_delivery_addresses_path
  	def index
  		@delivery_addresses = DeliveryAddress.all
  	end

		def new
			@address = DeliveryAddress.new
		end
  end
end