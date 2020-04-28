class AddTimeStampsToMunicipalities < ActiveRecord::Migration[6.0]
  def change
		add_column :municipalities, :created_at, :datetime
		add_column :municipalities, :updated_at, :datetime
  end
end
