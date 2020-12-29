# frozen_string_literal: true

class IrrigationType < ApplicationRecord
  validates :name, presence: true
end
