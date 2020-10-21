class Ranch < ApplicationRecord
  # acts_as_paranoid
  default_scope { order(:created_at) }
  validates :state, :municipality, :territory, :hydrological_region, :aquifer_name, :name, presence: true
  belongs_to :manager, class_name: "User", foreign_key: :manager_id, primary_key: :id
  has_many :areas, dependent: :destroy
  has_many :perforations, dependent: :destroy
  belongs_to :state
  belongs_to :municipality

  after_save :change_state_name

  delegate :change_state_name, to: :state, prefix: false

  delegate :name, to: :state, prefix: "state", allow_nil: :true
  delegate :name, to: :municipality, prefix: "municipality", allow_nil: :true
  delegate :name, to: :manager, prefix: "manager", allow_nil: :true

  has_rich_text :parcel_certificate
  has_one_attached :document

  def area_names
    areas.pluck(:name)
  end
end
