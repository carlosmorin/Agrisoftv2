module Directories
  class CarriersController < ApplicationController

  	add_breadcrumb "Directorios"
  	add_breadcrumb "Transportistas", :directories_carriers_path

  	def index
  		@carriers = Carrier.all
  	end

  end
end