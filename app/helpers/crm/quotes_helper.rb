# frozen_string_literal: true

module Crm::QuotesHelper
  def row_class(quote)
    return 'saled_row' if quote.folio?
    return 'canceled_row' if quote.cancel_quote?
    return 'inavlid_row' unless quote.valid

    ''
  end

  def sales_orders_row_class(order_sale)
    return 'saled_row' if order_sale.folio?
    return 'canceled_row' if order_sale.cancel_sale_order?

    ''
  end

  def row_sale_class(sale)
    return 'canceled_row' if sale.cancel_sale?

    ''
  end
end
