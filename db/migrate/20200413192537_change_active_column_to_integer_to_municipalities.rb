# frozen_string_literal: true

class ChangeActiveColumnToIntegerToMunicipalities < ActiveRecord::Migration[6.0]
  def change
    remove_column :municipalities, :active
    add_column :municipalities, :active, :integer
  end
end
