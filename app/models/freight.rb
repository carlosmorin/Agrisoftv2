class Freight < ApplicationRecord
  default_scope { order(:created_at) }
  scope :link_shipments, -> { where("folio IS NOT NULL") }
  #before_create :set_folio if shipments.first.order_sale_folio.nil?
  before_create :set_folio, if: -> { shipments.any? }
  before_update :set_folio, if: -> { folio.nil? }
  validates :carrier_id, :driver_id, :unit_id, :box_id, presence: true
  belongs_to :carrier, optional: true
  belongs_to :driver, optional: true
  belongs_to :unit, optional: true
  belongs_to :box, optional: true
  belongs_to :user, optional: true
  has_many :shipments, inverse_of: :freight, dependent: :destroy
  has_many :freights_taxes, inverse_of: :freight, dependent: :destroy
  accepts_nested_attributes_for :shipments, allow_destroy: true
  accepts_nested_attributes_for :freights_taxes, allow_destroy: true
  has_one_attached :pdf_invoice
  has_one_attached :xml_invoice
  belongs_to :debtable, polymorphic: true, optional: true

  private
  
  def set_folio
    year = Time.now.year
    total_freight = get_total_freight(year.to_s)
    year = year.to_s[2, 2]
    self.folio = "FF-#{year}-#{total_freight}"
  end
  
  def get_total_freight(year)
    total_freight = Freight.link_shipments.where('extract(year from created_at) = ?', year).size
    case total_freight.to_s.size
    when 1
      "000#{total_freight.to_i + 1 }"
    when 2
     "00#{total_freight.to_i + 1 }"
    when 3
      "0#{total_freight.to_i + 1 }"
    when 4
      "#{total_freight.to_i + 1 }"
    end
  end

end
