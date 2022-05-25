class AddSatFieldsToSupply < ActiveRecord::Migration[6.0]
  def change
    add_column :supplies, :sat_product, :string
    add_column :supplies, :sat_unit, :string
  end
end
