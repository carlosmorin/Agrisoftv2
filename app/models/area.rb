class Area < ApplicationRecord
  belongs_to :ranch
  belongs_to :irrigation_type
  validates :name, :territory, presence: true
end
