class Contract < ApplicationRecord
  belongs_to :client
  belongs_to :delivery_address
end
