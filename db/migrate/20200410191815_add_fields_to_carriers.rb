# frozen_string_literal: true

class AddFieldsToCarriers < ActiveRecord::Migration[6.0]
  def change
    add_column :carriers, :caat, :string
    add_column :carriers, :alpha, :string
    add_column :carriers, :iccmx, :string
    add_column :carriers, :usdot, :string
  end
end
