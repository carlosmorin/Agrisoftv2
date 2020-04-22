class AddCodeToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :code, :string
    add_column :clients, :shipments, :string
  end
end
