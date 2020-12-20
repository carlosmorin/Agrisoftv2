# frozen_string_literal: true

class AddNameToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :name, :string
    add_column :boxes, :name, :string
  end
end
