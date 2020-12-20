# frozen_string_literal: true

class Package < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, presence: true

  has_many :crops_packages, inverse_of: :package
  has_many :crops, through: :crops_packages

  has_many :products, inverse_of: :package
end
