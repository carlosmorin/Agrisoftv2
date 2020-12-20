# frozen_string_literal: true

class AddToSizes < ActiveRecord::Migration[6.0]
  def change
    add_column :sizes, :deleted_at, :datetime
  end
end
