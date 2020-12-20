# frozen_string_literal: true

class AddNameToDrivers < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :full_name, :string
  end
end
