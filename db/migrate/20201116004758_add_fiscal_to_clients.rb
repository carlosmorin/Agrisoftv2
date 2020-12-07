class AddFiscalToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :fiscal, :boolean
  end
end
