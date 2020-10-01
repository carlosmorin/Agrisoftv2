class ClientConfig < ApplicationRecord
  belongs_to :currency
  belongs_to :client
  enum pay_freight: [:client, :company, :no_one]
  enum client_type: [:national, :international]
end
