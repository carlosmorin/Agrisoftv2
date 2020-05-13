class ReportsController < ApplicationController
  def index
  	return if params[:year].nil?
  	@dates = Shipment.group("created_at::date").count
  	@shipments = Shipment.all
  	@shipment = Shipment.last
		render xlsx: "productos_report_#{DateTime.now().strftime("%m_%d_%Y")}", template: "reports/index.xlsx.axlsx"
  end
end