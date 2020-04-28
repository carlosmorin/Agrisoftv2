class AddNameContactToClientes < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :conact_name, :string
  end
end
