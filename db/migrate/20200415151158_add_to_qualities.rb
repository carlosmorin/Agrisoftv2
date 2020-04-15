class AddToQualities < ActiveRecord::Migration[6.0]
  def change
  	add_column :qualities, :deleted_at, :datetime
  end
end
