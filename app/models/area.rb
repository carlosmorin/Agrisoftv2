class Area < ApplicationRecord
  belongs_to :ranch
  validates :name, :territory, :type_of_irrigation, presence: true
end
