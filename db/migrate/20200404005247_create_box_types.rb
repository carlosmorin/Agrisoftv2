# frozen_string_literal: true

class CreateBoxTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :box_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
