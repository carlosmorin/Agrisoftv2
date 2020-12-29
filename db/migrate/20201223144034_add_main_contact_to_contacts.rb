class AddMainContactToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :main_contact, :boolean
  end
end
