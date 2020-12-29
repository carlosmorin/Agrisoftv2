# frozen_string_literal: true

class CreateTreatments < ActiveRecord::Migration[6.0]
  def change
    create_table :treatments do |t|
      t.integer :treatable_id
      t.string :treatable_type

      t.timestamps
    end
  end
end
