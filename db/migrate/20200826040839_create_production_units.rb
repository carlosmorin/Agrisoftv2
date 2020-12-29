# frozen_string_literal: true

class CreateProductionUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :production_units do |t|
      t.string :name

      t.timestamps
    end
  end
end
