# frozen_string_literal: true

class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :business_name
      t.string :rfc
      t.string :email
      t.string :phone
      t.integer :status
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
