# frozen_string_literal: true

class AddSatFieldsToBills < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :stamped_at, :datetime
    add_column :bills, :stamped_invoice, :text
    add_column :bills, :uuid, :string
    add_column :bills, :sat_folio, :string
    add_column :bills, :sat_serie, :string
    add_column :bills, :seal, :string
    add_column :bills, :certificate, :string
    add_column :bills, :certificate_number, :string
    add_column :bills, :sat_payment_method, :string
    add_column :bills, :sat_payment_mean, :string
    add_column :bills, :sat_currency, :string
    add_column :bills, :sat_currency_exchange_rate, :decimal, scale: 6, precision: 12
    add_column :bills, :sat_seal, :string
    add_column :bills, :sat_certificate_number, :string
    add_column :bills, :original_string, :text
  end
end
