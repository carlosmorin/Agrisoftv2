# frozen_string_literal: true

class CreateTaxes < ActiveRecord::Migration[6.0]
  def change
    create_table :taxes do |t|
      t.string 'name'
      t.integer 'value'
      t.timestamps
    end
  end
end
