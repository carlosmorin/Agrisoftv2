# frozen_string_literal: true

class AddTimeStampsToCarriers < ActiveRecord::Migration[6.0]
  def change
    add_column :carriers, :created_at, :datetime
    add_column :carriers, :updated_at, :datetime
  end
end
