class ProductionUnit < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  belongs_to :weight_unit, optional: true

  delegate :name, to: :weight_unit, prefix: "weight", allow_nil: :true
end
