class Treatment < ApplicationRecord
  # attr_accessor :crop_id
  belongs_to :treatable, polymorphic: true
  belongs_to :crop

  delegate :name, to: :crop, prefix: "crop", allow_nil: true
  has_many :treatment_supplies, dependent: :destroy

  has_rich_text :application_instructions

  delegate :supplies_count, :supplies_names, to: :treatment_supplies, prefix: false

  accepts_nested_attributes_for :treatment_supplies, allow_destroy: true

  def treatable_name
    return Pest.find(treatable_id).name if treatable_type == "Pest"
    Desease.find(treatable_id).name
  end
end
