class AddUserToShipment < ActiveRecord::Migration[6.0]
  def change
    add_reference :shipments, :user, foreign_key: true
  end
end
