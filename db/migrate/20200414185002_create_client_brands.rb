# frozen_string_literal: true

class CreateClientBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :client_brands do |t|
      t.string :name
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
