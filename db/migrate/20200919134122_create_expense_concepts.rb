# frozen_string_literal: true

class CreateExpenseConcepts < ActiveRecord::Migration[6.0]
  def change
    create_table :expense_concepts do |t|
      t.string :name

      t.timestamps
    end
  end
end
