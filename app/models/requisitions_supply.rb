class RequisitionsSupply < ApplicationRecord
  belongs_to :requisition
  belongs_to :supply
  belongs_to :unit_measure

  validates :supply_id, :unit_measure_id, :quantity, presence: true
end
