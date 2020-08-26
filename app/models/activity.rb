class Activity < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :production_unit
  validates :action, presence: true
end
