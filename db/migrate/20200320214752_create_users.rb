# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string 'email', default: '', null: false
      t.string 'name'
      t.string 'last_name'
      t.string 'phone'
      t.timestamps
    end
  end
end
