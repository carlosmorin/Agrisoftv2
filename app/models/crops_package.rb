class CropsPackage < ApplicationRecord
  belongs_to :crop
  belongs_to :package
	enum unit_meassure: [:lbs, :kg, :granel]
end
