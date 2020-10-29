module Crm
	class ReportPricesController < ApplicationController
  	before_action :set_object, only: %i[edit update destroy]

		def new
			@report = ShipmentsProductReport.new(
									shipments_product_id: params[:shipments_product_id], 
									currency_id: params[:currency_id]
								)
		end
		
		def edit
		end


		def create
      @report = ShipmentsProductReport.new(report_params)
    	@report.save!
		end

		def update
			@report.update(report_params)
		end

		def destroy
			@report.destroy
		end

    def report_params
      params.require(:shipments_product).permit( :id, :shipment_id, :product_id, 
      	:price, :quantity, :measurement_unit, :unit_meassure )
    end

    private

		def set_object
			id = params[:id]
			@report = ShipmentsProductReport.find(id)
		end
	end
end
