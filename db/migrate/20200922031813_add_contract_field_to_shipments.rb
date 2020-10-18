class AddContractFieldToShipments < ActiveRecord::Migration[6.0]
  def change
    add_reference :shipments, :contract, null: true	, foreign_key: true
  end
end
