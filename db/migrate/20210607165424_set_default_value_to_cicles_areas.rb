class SetDefaultValueToCiclesAreas < ActiveRecord::Migration[6.0]
  def change
    change_column :cicles_areas, :status, :integer, default: 0
  end
end
