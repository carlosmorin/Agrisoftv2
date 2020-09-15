class Appointment < ApplicationRecord
  belongs_to :shipment
	has_rich_text :comments
	validate :range_dates

	def valid
		self.finished_at.beginning_of_day > Time.now.end_of_day if self.finished_at.present?
	end

	private

	def range_dates
  	return if finished_at.nil? || started_at.nil?
    if started_at > finished_at
      errors.add(:finished_at, "Debe de ser mayor que la fecha de Inicio")
    end
  end
end
