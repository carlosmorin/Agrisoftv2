# frozen_string_literal: true

class CreateUnitBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :unit_brands do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end
  end
end
