# frozen_string_literal: true

class CropsQuality < ApplicationRecord
  belongs_to :crop
  belongs_to :quality
end
