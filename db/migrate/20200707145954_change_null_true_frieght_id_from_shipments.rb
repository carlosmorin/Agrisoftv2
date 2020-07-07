	class ChangeNullTrueFrieghtIdFromShipments < ActiveRecord::Migration[6.0]
  def change
  	change_column_null :shipments, :freight_id, true
  end
end
