class Fiscal < ApplicationRecord
  belongs_to :fiscalable, polymorphic: true
  has_many :addresses, as: :addressable
  accepts_nested_attributes_for :addresses, allow_destroy: true
  validates :bussiness_name, :rfc, presence: true
end