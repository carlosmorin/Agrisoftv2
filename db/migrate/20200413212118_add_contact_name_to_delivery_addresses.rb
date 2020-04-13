class AddContactNameToDeliveryAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_addresses, :contact_name, :string
    add_column :delivery_addresses, :email, :string
  end
end
