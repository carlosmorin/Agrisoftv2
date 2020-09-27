class TreatmentSupply < ApplicationRecord
  belongs_to :treatment
  belongs_to :supply

  def self.supplies_count
    all.size
  end
end
