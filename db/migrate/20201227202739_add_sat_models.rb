# frozen_string_literal: true

class AddSatModels < ActiveRecord::Migration[6.0]
  def change
    drop_table :sat_cfdi_usages
    drop_table :sat_ways_pays
    drop_table :sat_pay_methods
    create_table :sat_cfdi_usages do |t|
      t.string :code
      t.string :description
      t.boolean :physical_person
      t.boolean :moral_person
    end

    create_table :sat_fiscal_regimes do |t|
      t.string :code
      t.string :description
      t.boolean :physical_person
      t.boolean :moral_person
    end

    create_table :sat_payment_methods do |t|
      t.string :code
      t.string :description
    end

    create_table :sat_payment_means do |t|
      t.string :code
      t.string :description
    end

    %w[CfdiUsage PaymentMethod PaymentMean FiscalRegime].each do |catalog|
      "Sat::#{catalog}".constantize.setup_catalog
    end
  end
end
