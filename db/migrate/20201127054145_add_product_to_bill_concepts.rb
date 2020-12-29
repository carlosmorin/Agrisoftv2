# frozen_string_literal: true

class AddProductToBillConcepts < ActiveRecord::Migration[6.0]
  def change
    add_reference :bill_concepts, :product, null: false, foreign_key: true
  end
end
