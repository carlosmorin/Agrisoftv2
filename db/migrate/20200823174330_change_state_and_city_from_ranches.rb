# frozen_string_literal: true

class ChangeStateAndCityFromRanches < ActiveRecord::Migration[6.0]
  def change
    rename_column :ranches, :state, :state_id
    rename_column :ranches, :city, :municipality_id
  end
end
