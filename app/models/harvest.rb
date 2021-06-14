class Harvest < ApplicationRecord
  has_many :harvest_logs, inverse_of: :harvest, dependent: :destroy
  validates :harvest_at, :responsable, presence: true
  accepts_nested_attributes_for :harvest_logs, allow_destroy: true
  after_create :set_folio

  def set_folio
    folio_str = generate_folio
    self.update(folio: folio_str)
  end

  def generate_folio
    year = Time.zone.now.year
    case id.to_s.size
    when 1
      "#{year}000#{id}"
    when 2
      "#{year}00#{id}"
    when 3
      "#{year}0#{id}"
    when 4
      "#{year}#{id}"
    end
  end
end
