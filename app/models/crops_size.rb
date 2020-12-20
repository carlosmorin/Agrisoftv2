# frozen_string_literal: true

class CropsSize < ApplicationRecord
  belongs_to :crop
  belongs_to :size
end
