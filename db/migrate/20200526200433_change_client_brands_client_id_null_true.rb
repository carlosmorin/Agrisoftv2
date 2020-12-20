# frozen_string_literal: true

class ChangeClientBrandsClientIdNullTrue < ActiveRecord::Migration[6.0]
  def change
    change_column :client_brands, :client_id, :integer, null: true
  end
end
