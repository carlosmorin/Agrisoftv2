class AddStatusToCicles < ActiveRecord::Migration[6.0]
  def change
    add_column :cicles, :status, :integer, default: 0
  end
end
