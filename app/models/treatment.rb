class Treatment < ApplicationRecord
  belongs_to :treatable, polymorphic: true
  has_many :treatment_supplies, inverse_of: :treatment, dependent: :destroy

  accepts_nested_attributes_for :treatment_supplies, allow_destroy: true
end
