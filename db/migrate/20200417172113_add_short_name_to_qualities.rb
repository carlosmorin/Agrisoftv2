class AddShortNameToQualities < ActiveRecord::Migration[6.0]
  def change
  	add_column :qualities, :short_name, :string
  end
end
