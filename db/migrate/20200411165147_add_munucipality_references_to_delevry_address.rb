# frozen_string_literal: true

class AddMunucipalityReferencesToDelevryAddress < ActiveRecord::Migration[6.0]
  def change
    add_reference :delivery_addresses, :municipality, null: false, foreign_key: true
  end
end
