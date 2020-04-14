class Crop < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, presence: true
end
