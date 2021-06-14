# frozen_string_literal: true

class Area < ApplicationRecord
  belongs_to :ranch
  belongs_to :irrigation_type
  has_many :cicles_areas, inverse_of: :area, dependent: :destroy
  validates :name, :territory, presence: true
  validate :name_in_use?

  delegate :manager_name, to: :ranch, prefix: 'ranch', allow_nil: :true
  delegate :state_name, :municipality_name, to: :ranch, prefix: 'ranch', allow_nil: :true
  delegate :area_names, to: :ranch, prefix: false, allow_nil: :true
  delegate :name, :territory, :document, :hydrological_region, :aquifer_name, :georeference, to: :ranch, prefix: 'ranch', allow_nil: :true

  private

  def name_in_use?
    areas = area_names
    if areas.include?(name)
      errors.add(:area, ' ya esta en uno para este rancho')
    end
    # binding.pry
  end
end
