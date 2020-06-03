class ChangePriceToDecimalFromShipmentsProducts < ActiveRecord::Migration[6.0]
  def change
  	change_column :shipments_products, :price, :decimal
  end
end
