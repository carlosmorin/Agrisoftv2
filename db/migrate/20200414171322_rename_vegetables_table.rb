# frozen_string_literal: true

class RenameVegetablesTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :vegetables, :crops
  end
end
