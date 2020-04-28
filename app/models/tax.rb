class Tax < ApplicationRecord
	acts_as_paranoid
  default_scope { order(:created_at) }
	validates :name, :value, presence: true
	validates_uniqueness_of :name, case_sensitive: false
end
