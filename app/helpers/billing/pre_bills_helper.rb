# frozen_string_literal: true

module Billing::PreBillsHelper
  def check_expense?(expense_id)
    @sale.shipments_expenses.find(expense_id).prebill_expense?
  end

  def pre_bill_statuses
    {
      'Timbrada' => 'billed',
      'Canceleda' => 'canceled',
      'Sin timbrar' => 'not_billed'

    }
  end
end
