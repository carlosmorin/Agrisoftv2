class Presentation < ApplicationRecord
  belongs_to :weight_unit
  validates :name, :quantity, :weight_unit_id, :price, presence: true

  delegate :name, to: :weight_unit, prefix: "weight_unit", allow_nil: :true

  has_many :presentation_supplies
  has_many :supplies, through: :presentation_supplies

  accepts_nested_attributes_for :presentation_supplies
end
