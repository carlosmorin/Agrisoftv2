class AddCollectAtToShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments, :to_collect_at, :datetime
  end
end
