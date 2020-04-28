class AddStatusToRemision < ActiveRecord::Migration[6.0]
  def change
    add_column :remissions, :status, :integer
  end
end
