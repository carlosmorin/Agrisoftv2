# frozen_string_literal: true

class AddBillingDataToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :fiscal_regime, :string
    add_column :companies, :key, :binary
    add_column :companies, :certificate, :binary
    add_column :companies, :password, :string
    add_column :companies, :certificate_number, :string
  end
end
