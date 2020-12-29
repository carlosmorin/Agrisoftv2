# frozen_string_literal: true

class CreateSubStages < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_stages do |t|
      t.string :name

      t.timestamps
    end
  end
end
