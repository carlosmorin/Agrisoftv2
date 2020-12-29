# frozen_string_literal: true

class RemoveFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :name
    remove_column :users, :last_name
    remove_column :users, :phone
  end
end
