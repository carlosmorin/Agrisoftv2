class Perforation < ApplicationRecord
  belongs_to :ranch
  validates :name, :coordinates, :registry_number, :volume, :validity, :expenditure, presence: true
  has_one_attached :document
  has_rich_text :perforation_structure
end
