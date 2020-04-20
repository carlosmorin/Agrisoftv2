class ChangeConactToContactToClients < ActiveRecord::Migration[6.0]
  def change
  	rename_column :clients, :conact_name, :contact_name
  end
end
