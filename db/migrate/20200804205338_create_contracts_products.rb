# frozen_string_literal: true

class CreateContractsProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts_products do |t|
      t.references :contract, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :currency, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
