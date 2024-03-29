# frozen_string_literal: true

class CreateSatPayMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :sat_pay_methods do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
