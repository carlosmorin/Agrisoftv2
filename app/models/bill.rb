class Bill < ApplicationRecord
  belongs_to :company
  scope :pre_bills, -> { where("status = 1") }

  def folio
  	"000#{id}"
  end
end
