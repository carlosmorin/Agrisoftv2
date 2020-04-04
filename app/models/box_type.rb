class BoxType < ApplicationRecord
	default_scope { order(:created_at) }
	validates :name, presence: true
end
