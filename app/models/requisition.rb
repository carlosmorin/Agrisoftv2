class Requisition < ApplicationRecord
  belongs_to :user
  enum priority: { low: 0, hight: 1, very_hight: 2 }
  enum status: { active: 0, canceled: 1, expired: 2 }
  has_many :requisitions_supplies, dependent: :destroy
  accepts_nested_attributes_for :requisitions_supplies, allow_destroy: true




  PRIORITIES = {
    0 => 'NORMAL',
    1 => 'ALTA',
    2 => 'MUY ALTA'
  }.freeze

  STATUSES = {
  	0 => 'ACTIVA',
  	1 => 'CANCELADA',
  	2 => 'EXPIRADA'
  }
end
