class Package < ApplicationRecord
	acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, presence: true

  has_many :crops_packages
	has_many :packages, through: :crops_packages
end
