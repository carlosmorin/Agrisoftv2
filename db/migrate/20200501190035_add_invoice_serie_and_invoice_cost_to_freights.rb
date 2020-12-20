# frozen_string_literal: true

class AddInvoiceSerieAndInvoiceCostToFreights < ActiveRecord::Migration[6.0]
  def change
    add_column :freights, :invoice_serie, :string
    add_column :freights, :invoice_total, :integer
  end
end
