class AddCancelFiedlsToShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments, :cancel_quote, :boolean, default: false
    add_column :shipments, :cancel_sale_order, :boolean, default: false
    add_column :shipments, :cancel_sale, :boolean, default: false
  end
end
