class TreatmentSupply < ApplicationRecord
  attr_accessor :recommended_dose
  belongs_to :treatment
  belongs_to :supply

  def self.supplies_count
    all.size
  end
end
