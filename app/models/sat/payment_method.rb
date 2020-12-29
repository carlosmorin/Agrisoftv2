# frozen_string_literal: true

module Sat
  class PaymentMethod < ApplicationRecord
    def self.setup_catalog
      ActiveRecord::Base.transaction do
        destroy_all
        Sat::Catalog.payment_methods.each do |c|
          create!(code: c[0], description: c[1])
        end
      end
    end
  end
end
