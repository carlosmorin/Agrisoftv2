# frozen_string_literal: true

class AddDebtorableToFreights < ActiveRecord::Migration[6.0]
  def change
    add_reference :freights, :debtable, polymorphic: true
  end
end
