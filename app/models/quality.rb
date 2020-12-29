# frozen_string_literal: true

class Quality < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, presence: true

  has_many :crops_qualities, inverse_of: :quality
  has_many :crops, through: :crops_qualities, inverse_of: :quality
  has_many :products, inverse_of: :quality
end
