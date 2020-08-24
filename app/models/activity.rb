class Activity < ApplicationRecord
  belongs_to :user, optional: true
  validates :action, :production_unit, presence: true
end
