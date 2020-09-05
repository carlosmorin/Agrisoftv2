class Pest < ApplicationRecord
  has_many :crops_pests
  has_many :crops, through: :crops_pests
  has_many_attached :pictures, dependent: :destroy
  has_rich_text :description

  validates :name, :scientific_name, presence: true

  delegate :name, to: :crop, prefix: "crop", allow_nil: :true
end
