# frozen_string_literal: true

class CreateUnitMeasures < ActiveRecord::Migration[6.0]
  def change
    create_table :unit_measures do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end
  end
end
