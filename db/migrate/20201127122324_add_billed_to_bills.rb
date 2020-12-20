class AddBilledToBills < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :billed, :boolean
  end
end
