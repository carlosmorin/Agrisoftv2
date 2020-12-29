class AddBillingDataToFiscals < ActiveRecord::Migration[6.0]
  def change
    add_column :fiscals, :cfdi_usage, :string
    add_column :fiscals, :payment_method, :string
    add_column :fiscals, :payment_mean, :string
    add_column :fiscals, :external_vat, :string
  end
end
