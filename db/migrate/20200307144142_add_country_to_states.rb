# frozen_string_literal: true

class AddCountryToStates < ActiveRecord::Migration[6.0]
  def change
    add_reference :states, :country, foreign_key: true
  end
end
