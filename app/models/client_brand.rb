class ClientBrand < ApplicationRecord
  belongs_to :client
  validates :name, :client_id, presence: true  
  has_many :products, inverse_of: :client_brand
end
