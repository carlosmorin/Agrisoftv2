# frozen_string_literal: true

class CreateCropsPackages < ActiveRecord::Migration[6.0]
  def change
    create_table :crops_packages do |t|
      t.references :crop, null: false, foreign_key: true
      t.references :package, null: false, foreign_key: true
      t.integer :weight
      t.integer :unit_meassure

      t.timestamps
    end
  end
end
