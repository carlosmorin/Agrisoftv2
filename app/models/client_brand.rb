class ClientBrand < ApplicationRecord
  belongs_to :client
  validates :name, :client_id, presence: true  
end
