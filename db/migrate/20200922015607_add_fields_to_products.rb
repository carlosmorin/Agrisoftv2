# frozen_string_literal: true

class AddFieldsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :units_per_pallet, :integer
  end
end
