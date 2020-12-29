# frozen_string_literal: true

module Crm
  class ExpensesController < ApplicationController
    before_action :set_object, only: %i[edit update destroy]

    def new
      @expense = ShipmentsExpense.new(
        shipment_id: params[:shipment_id],
        currency_id: params[:currency_id]
      )
     end

    def edit; end

    def create
      @expense = ShipmentsExpense.new(expense_params)
      @expense.save!
     end

    def update
      @expense.update(expense_params)
     end

    def destroy
      @expense.destroy
     end

    def expense_params
      params.require(:shipments_expense).permit(:id, :shipment_id,
                                                :currency_id, :expense_id, :unit, :total, :amount, :percentage,
                                                :type_expense)
    end

    def build_detail
      @sale = Shipment.find(params[:sale_id])
      @expense = ShipmentsExpense.find(params[:expense_id])
    end

    private

    def set_object
      id = params[:id]
      @expense = ShipmentsExpense.find(id)
     end
  end
end
