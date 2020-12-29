# frozen_string_literal: true

class CreateMunicipalities < ActiveRecord::Migration[6.0]
  def change
    create_table :municipalities do |t|
      t.references :state, null: false, foreign_key: true
      t.string :key
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
