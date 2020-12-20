# frozen_string_literal: true

class CreateSatWaysPays < ActiveRecord::Migration[6.0]
  def change
    create_table :sat_ways_pays do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
