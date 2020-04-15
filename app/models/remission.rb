class Remission < ApplicationRecord
  belongs_to :company
  belongs_to :client
  belongs_to :carrier
  belongs_to :unit
  belongs_to :box
  belongs_to :delivery_address
end
