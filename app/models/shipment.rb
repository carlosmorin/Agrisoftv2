class Shipment < ApplicationRecord
  belongs_to :carrier
  belongs_to :driver
  belongs_to :unit
  belongs_to :box
  belongs_to :user
end
