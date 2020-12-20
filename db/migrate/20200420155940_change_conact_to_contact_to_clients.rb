# frozen_string_literal: true

class ChangeConactToContactToClients < ActiveRecord::Migration[6.0]
  def change
    rename_column :clients, :conact_name, :contact_name
  end
end
