# frozen_string_literal: true

class AddFiscalFieldsToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :fiscal, :boolean
    add_column :addresses, :crosses, :string
    add_column :addresses, :locality, :string
  end
end
