# frozen_string_literal: true

class CreateFreightsTaxes < ActiveRecord::Migration[6.0]
  def change
    create_table :freights_taxes do |t|
      t.references :freight, null: false, foreign_key: true
      t.references :tax, null: false, foreign_key: true
      t.decimal :value

      t.timestamps
    end
  end
end
