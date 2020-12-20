# frozen_string_literal: true

class BoxType < ApplicationRecord
  default_scope { order(:id) }
  validates :name, presence: true
  has_many :boxes, inverse_of: :box_type
end
