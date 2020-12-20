# frozen_string_literal: true

class AddAddressFieldsToClients < ActiveRecord::Migration[6.0]
  def change
    add_reference :clients, :country, foreign_key: true
    add_reference :clients, :municipality, foreign_key: true
    add_column :clients, :cp, :string
  end
end
