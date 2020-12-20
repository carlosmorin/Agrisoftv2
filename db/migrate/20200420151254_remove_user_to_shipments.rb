# frozen_string_literal: true

class RemoveUserToShipments < ActiveRecord::Migration[6.0]
  def change
    remove_column :shipments, :user_id
  end
end
