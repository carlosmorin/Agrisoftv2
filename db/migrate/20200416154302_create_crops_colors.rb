# frozen_string_literal: true

class CreateCropsColors < ActiveRecord::Migration[6.0]
  def change
    create_table :crops_colors do |t|
      t.references :crop, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true

      t.timestamps
    end
  end
end
