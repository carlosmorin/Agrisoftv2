class Appointment < ApplicationRecord
  belongs_to :shipment
	has_rich_text :comments

	def valid
		self.finished_at.beginning_of_day > Time.now.end_of_day if self.finished_at.present?
	end
end
