# frozen_string_literal: true

class AddAddressFieldsToCarriers < ActiveRecord::Migration[6.0]
  def change
    add_reference :carriers, :country, null: false, foreign_key: true
    add_reference :carriers, :state, null: false, foreign_key: true
    add_reference :carriers, :municipality, null: false, foreign_key: true
    add_column :carriers, :email, :string
  end
end
