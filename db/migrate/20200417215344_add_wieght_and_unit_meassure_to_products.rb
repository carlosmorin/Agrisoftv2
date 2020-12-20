# frozen_string_literal: true

class AddWieghtAndUnitMeassureToProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :crops_packages, :weight
    remove_column :crops_packages, :unit_meassure

    add_column :products, :wieght, :integer
    add_column :products, :unit_meassure, :integer
  end
end
