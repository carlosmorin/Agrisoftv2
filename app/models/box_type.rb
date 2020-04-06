class BoxType < ApplicationRecord
	default_scope { order(:id) }
	validates :name, presence: true
end
