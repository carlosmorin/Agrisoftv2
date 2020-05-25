module Commercial
  class SalesController < ApplicationController
  	add_breadcrumb "Commercial", :commercial_root_path
  	add_breadcrumb "Ventas", :commercial_sales_path
  	
  	def index
  		@sales = Shipment.all
  	end
  end
end