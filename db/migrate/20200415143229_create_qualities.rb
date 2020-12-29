# frozen_string_literal: true

class CreateQualities < ActiveRecord::Migration[6.0]
  def change
    create_table :qualities do |t|
      t.string :name
      t.timestamps
    end
  end
end
