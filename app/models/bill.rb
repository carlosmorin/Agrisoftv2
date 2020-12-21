# frozen_string_literal: true

class Bill < ApplicationRecord
  belongs_to :client, inverse_of: :bills
  belongs_to :company, inverse_of: :bills
  belongs_to :currency, inverse_of: :bills
  belongs_to :fiscal, inverse_of: :bills
  belongs_to :user, inverse_of: :bills
  belongs_to :shipment, inverse_of: :bills
  scope :pre_bills, -> { where('status = 1') }
  has_many :bill_concepts, inverse_of: :bill, dependent: :destroy
  accepts_nested_attributes_for :bill_concepts, allow_destroy: true

  has_one_attached :external_xml
  has_one_attached :external_pdf

  validates :fiscal_id, presence: true, if: -> { client&.fiscal? }
  validates :uuid, uniqueness: true, unless: proc { |i| i.uuid.nil? }
  validates :external_xml, :external_pdf, :external_folio, presence: true, if: -> { billed? }

  after_create :set_folio
  before_create :set_due_date

  enum status: { not_billed: 1, canceled: 2, billed: 3 }

  def set_folio
    update(serie: get_serie('FAC-', id))
  end

  def total_products
    shipment.n_products
  end

  def assign_cfdi_attributes(attrs = {})
    return unless attrs

    update_attributes(attrs)
  end

  private

  def set_due_date
    start_date = client.start_date.eql?('sale') ? shipment.shipment_at : pre_billed_at
    self.due_at = start_date + client.credit_days.days
  end

  def get_serie(prefix, id)
    case id.to_s.size
    when 1
      "#{prefix}000#{id}"
    when 2
      "#{prefix}00#{id}"
    when 3
      "0#{id}"
    when 4
      "#{prefix}#{id}"
    end
  end
end
