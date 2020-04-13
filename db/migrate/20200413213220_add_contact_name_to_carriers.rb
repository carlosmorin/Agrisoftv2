class AddContactNameToCarriers < ActiveRecord::Migration[6.0]
  def change
    add_column :carriers, :contact_name, :string
  end
end
