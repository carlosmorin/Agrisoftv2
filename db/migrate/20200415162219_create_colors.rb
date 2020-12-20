# frozen_string_literal: true

class CreateColors < ActiveRecord::Migration[6.0]
  def change
    create_table :colors do |t|
      t.string :name
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
