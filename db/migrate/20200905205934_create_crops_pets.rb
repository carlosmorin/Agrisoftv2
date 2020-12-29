# frozen_string_literal: true

class CreateCropsPets < ActiveRecord::Migration[6.0]
  def change
    create_table :crops_pests do |t|
      t.references :crop, null: false, foreign_key: true
      t.references :pest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
