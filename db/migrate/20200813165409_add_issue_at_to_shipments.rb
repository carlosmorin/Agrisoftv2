class AddIssueAtToShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments, :issue_at, :datetime
    add_column :shipments, :currency, :integer
    add_column :shipments, :expirated_days, :integer
    add_column :shipments, :exchange_rate, :decimal
    add_column :shipments, :discount, :decimal
    add_column :shipments, :iva, :decimal
    add_reference :shipments, :user, null: false, foreign_key: true
    add_reference :shipments, :contact, null: false, foreign_key: true
  end
end
