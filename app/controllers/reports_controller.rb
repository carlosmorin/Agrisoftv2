class ReportsController < ApplicationController
  def index
  	return if params[:year].nil?
  	@dates = Shipment.group("created_at::date").count
  	@shipments = Shipment.all
  	@shipment = Shipment.last
		render xlsx: "stock_status_report", template: "reports/index.xlsx.axlsx"
  end
end