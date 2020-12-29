# frozen_string_literal: true

class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :name
      t.string :territory
      t.string :type_of_irrigation
      t.references :ranch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
