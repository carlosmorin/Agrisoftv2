class Area < ApplicationRecord
  belongs_to :ranch
  belongs_to :irrigation_type
  validates :name, :territory, presence: true

  delegate :manager_name, to: :ranch, prefix: "ranch", allow_nil: :true
  delegate :state_name, :municipality_name, to: :ranch, prefix: "ranch", allow_nil: :true
  delegate :name, :territory, :document, :hydrological_region, :aquifer_name, :georeference, to: :ranch, prefix: "ranch", allow_nil: :true
end
