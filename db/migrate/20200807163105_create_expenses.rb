# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.string :name

      t.timestamps
    end
  end
end
