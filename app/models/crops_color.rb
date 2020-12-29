# frozen_string_literal: true

class CropsColor < ApplicationRecord
  belongs_to :crop
  belongs_to :color
end
