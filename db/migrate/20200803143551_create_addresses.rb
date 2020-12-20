# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.text :name
      t.string :street
      t.string :outdoor_number
      t.string :interior_number
      t.string :cp
      t.string :references
      t.string :neighborhood
      t.string :phone
      t.references :country, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
      t.text :comments
      t.integer :status
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
