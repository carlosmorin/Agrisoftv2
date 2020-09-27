class Treatment < ApplicationRecord
  belongs_to :treatable, polymorphic: true
  has_many :treatment_supplies, inverse_of: :treatment, dependent: :destroy

  has_rich_text :application_instructions

  delegate :supplies_count, to: :treatment_supplies, prefix: false

  accepts_nested_attributes_for :treatment_supplies, allow_destroy: true
end
