# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :crop, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.references :quality, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.references :package, null: false, foreign_key: true
      t.references :client_brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
