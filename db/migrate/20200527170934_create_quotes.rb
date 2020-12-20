# frozen_string_literal: true

class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.references :client, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :expirated_days
      t.date :expired_at
      t.string :folio
      t.decimal :iva

      t.timestamps
    end
  end
end
