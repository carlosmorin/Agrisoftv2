# frozen_string_literal: true

class ClientConfig < ApplicationRecord
  belongs_to :currency
  belongs_to :client
  enum pay_freight: %i[client company no_one]
  enum client_type: %i[national international]
end
