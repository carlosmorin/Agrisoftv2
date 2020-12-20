# frozen_string_literal: true

class CreateSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.text :description
      t.references :categorytable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
