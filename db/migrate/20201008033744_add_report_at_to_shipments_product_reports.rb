# frozen_string_literal: true

class AddReportAtToShipmentsProductReports < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments_product_reports, :report_at, :datetime
  end
end
