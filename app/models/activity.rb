class Activity < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :production_unit
  validates :action, presence: true

  delegate :name, :weight, :weight_name, to: :production_unit, prefix: "production_unit", allow_nil: :true
end
