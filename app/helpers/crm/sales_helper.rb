module Crm::SalesHelper
	def units_sales
		{ 
			'Precio de venta': 'price_sale', 
			'Bulto': 'package', 
			'Pallet': 'pallet'
		}
	end

	def types_expenses
		{ 
			'Gasto': 'expense_type', 
			'Descuento': 'discount_type'
		}
	end

	def get_total(unit_sale, price, percentage)
		return total_by_price_sale(price, percentage) if unit_sale == 'price_sale' 
		return total_by_package(price, percentage) if unit_sale == 'package'
		return total_by_freight(price, percentage) if unit_sale == 'freight'
	end

	def total_by_price_sale(price, percentage)
		return get_porcent(@sale.total, price) if percentage
		price
	end

	def total_by_package(price, percentage)
		@sale.n_products * price 
	end

	def total_by_freight(price, percentage)
		price
	end


	def currency(price, code)
		price = 0 if price.nil?
		"$ #{number_to_currency(price, unit: '')}<small>#{code&.upcase}</small>"
	end

	def to_percentage(percentage)
		"#{percentage} %"
	end

	def currency_usd_to_mxn(price)
		"#{price * @sale.exchange_rate}<small>MXN</small>"
	end

	def currency_mxn_to_usd_str(price, exchange_rate)
		return '0' if price.nil? || price.zero? || exchange_rate.nil?
		if exchange_rate.nil?
			"#{0}"
		else
			"#{price / exchange_rate} "
		end
	end

	def currency_mxn_to_usd(price, exchange_rate)
		return '0' if price.nil? || price.zero? || exchange_rate.nil?
		if exchange_rate.nil?
			currency(0, 'USD')
		else
			currency(price / exchange_rate, 'USD')
		end
	end

	def get_porcent(amount, percent)
		(amount / 100) * percent
	end

	def get_porcent2(amount1, amount2)
		return 100 if amount1.eql?(amount2)
		min = amount1.to_f / 100
		amount2.to_f / min
	end

	def get_total_row_mxn(amount, code)
		return amount if code == 'mxn'
		amount * @sale.exchange_rate
	end


	def progress_bar(sale, size = 'md')
		porcentage = get_porcent2(sale.total_quantity, sale.total_quantity_reported)
			color_bar = case porcentage
								when 0..30
									"bg-warning"
								when 31..60
									"bg-info"
								when 61..99
									"bg-primary"
								when 100
									"bg-success"
								else
									"bg-default"
								end
		html = "<span class='progress progress-#{size} mt-1'>"
		html += "<span class='progress-bar progress-bar-success progress-bar-striped #{color_bar}' aria-valuemax='100' aria-valuemin='0' aria-valuenow='25' role='progressbar' style='width: #{porcentage}%;'>"
		html += "#{porcentage.round(2)} %"
		html += "</span>"
		html += "</span>"
		html
	end

	def type_expense(expense)
		return "<span class='badge badge-primary right s-10'> Gasto </span>" if expense.expense_type?
		return "<span class='badge badge-info right s-10'> Descuento </span>" if expense.discount_type?
	end

	def type_expense_str(expense)
		return "Gasto" if expense.expense_type?
		return "Descuento" if expense.discount_type?
	end

	def get_cost_expense(sale, quantity, expense_quantity)
		porcent = (100 / sale.total_quantity.to_d) * quantity
		(expense_quantity / 100) * porcent
	end

	def get_cost_expense_2(report_price, sale_total)
		porcent = 100 / sale_total.to_d * report_price.to_d
		total = sale_total.to_d / 100 * porcent
		total_porcent = total / sale_total.to_d
		@expense.get_total * total_porcent
	end
end
