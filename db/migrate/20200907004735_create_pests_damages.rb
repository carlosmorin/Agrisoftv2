# frozen_string_literal: true

class CreatePestsDamages < ActiveRecord::Migration[6.0]
  def change
    create_table :pests_damages do |t|
      t.references :pest, null: false, foreign_key: true
      t.references :damage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
