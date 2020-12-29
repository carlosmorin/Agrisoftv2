# frozen_string_literal: true

class AddToVegetables < ActiveRecord::Migration[6.0]
  def change
    add_column :vegetables, :deleted_at, :datetime
  end
end
