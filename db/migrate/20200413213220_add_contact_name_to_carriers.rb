# frozen_string_literal: true

class AddContactNameToCarriers < ActiveRecord::Migration[6.0]
  def change
    add_column :carriers, :contact_name, :string
  end
end
