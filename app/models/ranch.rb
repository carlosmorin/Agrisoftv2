class Ranch < ApplicationRecord
  # acts_as_paranoid
  default_scope { order(:created_at) }
  validates :state, :city, :territory, :hydrological_region, :aquifer_name, presence: true
  belongs_to :manager, class_name: "User", foreign_key: :manager_id, primary_key: :id
  has_many :areas, dependent: :destroy
  has_many :perforations, dependent: :destroy

  has_rich_text :parcel_certificate
  has_one_attached :document
end
