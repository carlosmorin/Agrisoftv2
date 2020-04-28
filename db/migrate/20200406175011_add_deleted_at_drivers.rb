class AddDeletedAtDrivers < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :deleted_at, :datetime
  end
end
