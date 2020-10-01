module Crm::SalesHelper
	def units_sales
		{ 
			'Precio de venta': 'price_sale', 
			'Bulto': 'package', 
			'Viaje/envio': 'freight', 
			'Pallet': 'pallet'
		}
	end

	def get_total(unit_sale, price, percentage)
		return total_by_price_sale(price, percentage) if unit_sale == 'price_sale' 
		return total_by_package(price, percentage) if unit_sale == 'package' 
		return total_by_freight(price, percentage) if unit_sale == 'freight'
	end

	def total_by_price_sale(price, percentage)
		return get_porcent(@sale.total_mxn, price) if percentage
		price
	end

	def total_by_package(price, percentage)
		@sale.n_products * price 
	end

	def total_by_freight(price, percentage)
		price * 1
	end

	def currency(price, code)
		"$ #{number_to_currency(price, unit: '')}<small>#{code.upcase}</small>"
	end

	def to_percentage(percentage)
		"#{percentage} %"
	end

	def currency_usd_to_mxn(price)
		"#{price * @sale.exchange_rate}<small>MXN</small>"
	end

	def currency_mxn_to_usd(price)
		currency(price / @sale.exchange_rate, 'USD')
	end

	def get_porcent(amount, percent)
		(amount / 100) * percent
	end

	def get_total_row_mxn(amount, code)
		return amount if code == 'mxn'
		amount * @sale.exchange_rate
	end
end
