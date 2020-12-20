# frozen_string_literal: true

class AddQuoteFieldsToShipment < ActiveRecord::Migration[6.0]
  def change
    add_reference :shipments, :user, foreign_key: true
    add_reference :shipments, :contact, foreign_key: true
    add_column :shipments, :issue_at, :datetime
    add_column :shipments, :expirated_days, :integer
    add_column :shipments, :iva, :integer
    add_column :shipments, :discount, :integer
    add_column :shipments, :quote_folio, :string
    add_column :shipments, :currency, :integer
    add_column :shipments, :exchange_rate, :decimal
  end
end
