# frozen_string_literal: true

class AddMunicipalityToCarriers < ActiveRecord::Migration[6.0]
  def change
    add_column :carriers, :municipality, :string
  end
end
