class Requisition < ApplicationRecord
  include FolioGenerator

  belongs_to :user
  enum priority: { normal: 0, hight: 1, urgent: 2 }
  enum status: { unauthorized: 0, authorized: 1, expired: 2, canceled: 3 }
  has_many :requisitions_supplies, inverse_of: :requisition, dependent: :destroy
  accepts_nested_attributes_for :requisitions_supplies, allow_destroy: true
  validates :user_id, :department, :limit_at, :priority, presence: true
  after_create :set_folio

  scope :currents, -> { where("limit_at > ?", Date.today) }
  scope :expired, -> { where("limit_at < ?", Date.today) }

  PRIORITIES = {
    normal: 'NORMAL',
    hight: 'ALTA',
    urgent: 'URGENTE'
  }.freeze

  STATUSES = {
    unauthorized: 'Sin autorizar',
    authorized: 'Autorizada',
    expired: 'Expirada',
    canceled: 'Cancelada'
  }.freeze


  def set_folio
    self.update(folio: "REQ-#{get_serie(id)}")
  end

  def supplies_total
    requisitions_supplies.sum(:quantity)
  end
end
