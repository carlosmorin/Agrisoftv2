# frozen_string_literal: true

class AddDueAtToBills < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :due_at, :datetime
  end
end
