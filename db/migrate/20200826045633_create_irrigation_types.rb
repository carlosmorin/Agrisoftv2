# frozen_string_literal: true

class CreateIrrigationTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :irrigation_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
