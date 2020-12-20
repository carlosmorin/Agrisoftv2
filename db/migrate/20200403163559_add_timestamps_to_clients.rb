# frozen_string_literal: true

class AddTimestampsToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :created_at, :datetime
    add_column :clients, :updated_at, :datetime
  end
end
