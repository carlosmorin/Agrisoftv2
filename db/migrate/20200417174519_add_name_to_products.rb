# frozen_string_literal: true

class AddNameToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :name, :string
  end
end
