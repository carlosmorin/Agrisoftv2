# frozen_string_literal: true

class CreateHosts < ActiveRecord::Migration[6.0]
  def change
    create_table :hosts do |t|
      t.string :name

      t.timestamps
    end
  end
end
