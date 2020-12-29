# frozen_string_literal: true

class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.string :name
      t.references :client, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at
      t.boolean :all_products
      t.references :delivery_address, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :comments

      t.timestamps
    end
  end
end
