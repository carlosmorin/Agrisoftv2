class Perforation < ApplicationRecord
  belongs_to :ranch
  validates :name, :coordinates, :registry_number, :volume, :validity, :expenditure, presence: true
  has_one_attached :document
  has_rich_text :perforation_structure

  delegate :manager_name, to: :ranch, prefix: "ranch", allow_nil: :true
  delegate :state_name, :municipality_name, to: :ranch, prefix: "ranch", allow_nil: :true
  delegate :name, :territory, :document, :hydrological_region, :aquifer_name, :georeference, to: :ranch, prefix: "ranch", allow_nil: :true
end
