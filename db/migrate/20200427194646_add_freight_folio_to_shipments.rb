class AddFreightFolioToShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments, :freight_folio, :string
  end
end
