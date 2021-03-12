class RequisitionsSupply < ApplicationRecord
  belongs_to :requisition
  belongs_to :supply
end
