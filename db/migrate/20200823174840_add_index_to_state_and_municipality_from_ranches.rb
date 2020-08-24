class AddIndexToStateAndMunicipalityFromRanches < ActiveRecord::Migration[6.0]
  def change
    add_index :ranches, :municipality_id
    add_index :ranches, :state_id
  end
end
