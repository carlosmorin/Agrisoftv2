# frozen_string_literal: true

class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.string :sat_cfdi_usage
      t.string :sat_pay_method
      t.string :sat_ways_pay
      t.references :company, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :currency, null: false, foreign_key: true
      t.references :shipment, null: true, foreign_key: true
      t.integer :credit_days, default: 0
      t.integer :status, default: 1
      t.integer :exchange_rate, default: 0
      t.text :comments

      t.timestamps
    end
  end
end
