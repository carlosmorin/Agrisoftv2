# frozen_string_literal: true

module Sat
  class CfdiUsage < ApplicationRecord
    def self.setup_catalog
      ActiveRecord::Base.transaction do
        destroy_all
        Sat::Catalog.cfdi_usages.each do |c|
          create!(code: c[0], description: c[1], physical_person: c[2],
                  moral_person: [3])
        end
      end
    end
  end
end
