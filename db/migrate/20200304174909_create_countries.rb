# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :short_name
      t.timestamps
    end
  end
end
