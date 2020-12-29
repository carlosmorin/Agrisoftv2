# frozen_string_literal: true

class RenameShipmentsTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :shipments, :freights
    rename_table :remissions, :shipments
  end
end
