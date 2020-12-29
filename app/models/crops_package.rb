# frozen_string_literal: true

class CropsPackage < ApplicationRecord
  belongs_to :crop
  belongs_to :package
  enum unit_meassure: %i[lbs kg granel]
end
