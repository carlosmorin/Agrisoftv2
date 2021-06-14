class CiclesArea < ApplicationRecord
  belongs_to :cicle
  belongs_to :area
  has_many :cicles_areas_logs

  validates :area_id, :started_at, :finished_at, presence: true
  validates :name, uniqueness: true, presence: true
  enum status: { available: 0, busy: 1 }

  scope :currents, -> { where("? BETWEEN started_at AND finished_at", Time.now.to_date)}

  def cicle_area_log
  	return if cicles_areas_logs.empty?
  	cicles_areas_logs.first
  end
end
