# frozen_string_literal: true

class CreateDeliveryAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_addresses do |t|
      t.references :client, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
