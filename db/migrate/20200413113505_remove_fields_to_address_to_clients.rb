class RemoveFieldsToAddressToClients < ActiveRecord::Migration[6.0]
  def change
  	remove_column :clients, :country
  	remove_column :clients, :state
  	remove_column :clients, :cp
  end
end
