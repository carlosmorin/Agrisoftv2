# frozen_string_literal: true

class AddPayClientPayCompanyToFreights < ActiveRecord::Migration[6.0]
  def change
    add_column :freights, :pay_client, :boolean
    add_column :freights, :pay_company, :boolean
    add_column :freights, :cost, :decimal
    add_column :freights, :currency, :integer
  end
end
