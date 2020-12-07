class ClientConfig < ApplicationRecord
  belongs_to :currency
  belongs_to :client
  enum pay_freight: [:client, :company, :no_one]
  enum client_type: [:national, :international]
  enum date_due: [:sale, :bill]
end
