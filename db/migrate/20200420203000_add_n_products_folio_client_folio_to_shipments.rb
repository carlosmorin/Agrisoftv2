class AddNProductsFolioClientFolioToShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments, :n_products, :integer
    add_column :shipments, :folio, :string
    add_column :shipments, :client_folio, :string
  end
end
