# frozen_string_literal: true

class AddBillingDataToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :fiscal_name, :string
    add_column :clients, :cfdi_usage, :string
    add_column :clients, :paymenth_method, :string
    add_column :clients, :payment_mean, :string
    add_column :clients, :external_vat, :string
  end
end
