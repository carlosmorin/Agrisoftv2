# frozen_string_literal: true

class CreateActiveIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :active_ingredients do |t|
      t.string :name

      t.timestamps
    end
  end
end
