class TreatmentSupply < ApplicationRecord
  # attr_accessor :supply_id
  jsonb_accessor :recommended_dose, 
    irrigation_quantity: :string,
    irrigation_unit: :string,
    foliar_quantity: :string,
    foliar_unit: :string
  belongs_to :treatment
  belongs_to :supply

  delegate :name, to: :supply, prefix: "supply", allow_nil: true

  def self.supplies_count
    all.size
  end

  def self.supplies_names
    all.map(&:supply_name)
  end
end
