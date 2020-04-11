class DeliveryAddress < ApplicationRecord
  belongs_to :client
  belongs_to :country
  belongs_to :state
end
