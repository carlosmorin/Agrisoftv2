class AddNameToRanch < ActiveRecord::Migration[6.0]
  def change
    add_column :ranches, :name, :string
  end
end
