# frozen_string_literal: true

class AddEmailAndStateToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :email, :string
    add_reference :clients, :state, foreign_key: true
  end
end
