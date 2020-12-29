# frozen_string_literal: true

class CreateWeightUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :weight_units do |t|
      t.string :name

      t.timestamps
    end
  end
end
