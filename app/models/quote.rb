class Quote < ApplicationRecord
  belongs_to :client
  belongs_to :company
  belongs_to :contact
  belongs_to :user
	has_rich_text :description
	has_many :shipments_products, as: :productable
	accepts_nested_attributes_for :shipments_products, allow_destroy: true

	def expirated_at
		issue_at + expirated_days.days
	end

	def subtotal
		subTotal = 0
		shipments_products.map { |product| 
			subTotal += (product.quantity.to_i * product.price.to_i) }
		subTotal 
	end
end
