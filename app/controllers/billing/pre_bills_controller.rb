# frozen_string_literal: true

module Billing
  class PreBillsController < ApplicationController
    before_action :set_bill, only: %i[show edit manual_stamp destroy cancel]
    before_action :set_form_params, only: [:index]
    add_breadcrumb 'Facturación'
    add_breadcrumb 'Pre facturas'

    def index
      @pre_bills = Bill.all.order('created_at ASC').paginate(page: params[:page], per_page: 25)

      filters
    end

    def show
      @sale = Shipment.find_by_folio(params[:sale])
    end

    # GET /rooms/new
    def new
      build_prebill if params[:sale].present?
      @pre_bill = Bill.new(@fields)
      @pre_bill.bill_concepts.new if @pre_bill.bill_concepts.empty?
    end

    # GET /rooms/1/edit
    def edit; end

    # POST /rooms
    # POST /rooms.json
    def create
      @pre_bill = Bill.new(bill_params)
      if @pre_bill.save
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Fcatura creada correctamente"
        redirect_to crm_sale_manage_path(@pre_bill.shipment, tab: :bills)
      else
        @sale = @pre_bill.shipment
        render :new
      end
    end

    # PATCH/PUT /rooms/1
    # PATCH/PUT /rooms/1.json
    def manual_stamp
      if @bill.update(bill_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Factura timbrada correctamente"
        redirect_to billing_pre_bill_path(@bill)
      else
        flash[:alert] = "<i class='fa fa-check-circle mr-1 s-18'></i> Error al timbrar"
        redirect_to billing_pre_bill_path(@bill)
      end
    end

    # DELETE /rooms/1
    # DELETE /rooms/1.json
    def destroy
      @room.destroy
      respond_to do |format|
        format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def bill_params
      params.require(:bill).permit(
        :company_id, :client_id, :user_id, :currency_id, :shipment_id,
        :credit_days, :id, :external_folio, :status, :exchange_rate, :comments,
        :pre_billed_at, :fiscal_id, :subtotal, :discount, :expenses, :total, :external_xml,
        :external_pdf, bill_concepts_attributes: %i[id description quantity
                                                    discount unit_price import bill product_id _destroy]
      )
    end

    def update_discounts
      @expenses = ShipmentsExpense.where(id: params[:discounts])
      if params[:discount_include].nil?
        @expenses.update_all(prebill_expense: false)
      else
        @expenses.each_with_index do |expense, index|
          if params[:discount_include][index.to_s].eql?('on')
            expense.update!(prebill_expense: true)
          else
            expense.update!(prebill_expense: false)
          end
        end
      end
      render status: 200, json: load_response.to_json
    end

    def cancel
      @bill.update(status: :canceled)
    end

    private

    def load_response
      load_sale_by_id(params[:pre_bill_id])
      total = 0
      expenses = ShipmentsExpense.where(id: params[:discounts])
      expenses.where(prebill_expense: true).each do |expense|
        total += expense.get_total
      end
      { quantity: @sale.n_products, total: total }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    def build_prebill
      load_sale
      @fields = {}
      @fields[:company_id] = @sale.company_id
      @fields[:shipment_id] = @sale.id
      @fields[:client_id] = @sale.client_id
      @fields[:currency_id] = @sale.current_currency.id
      @fields[:exchange_rate] = @sale.exchange_rate
      @fields[:bill_concepts_attributes] = []
      build_prebill_concepts
      @fields[:subtotal] = @subtotal
      @fields[:total] = @subtotal
    end

    def get_subtotal
      total = 0
      @sale.shipments_products.each do |sp|
        total += sp.total
      end
      total
    end

    def build_prebill_concepts
      concepts_hash = {}
      @subtotal = 0
      @sale.shipments_products.each do |shp|
        unit_price = shp.price.zero? ? shp.sale_price : shp.price
        unit_price = params[:initial_bill].present? ? 1 : unit_price.round(2)
        fields = {
          description: shp.product.name,
          product_id: shp.product.id,
          quantity: shp.quantity,
          unit_price: unit_price,
          import: shp.quantity * unit_price
        }
        @subtotal += shp.quantity * unit_price

        @fields[:bill_concepts_attributes].push(fields)
      end
      @subtotal
    end

    def set_bill
      id = params[:id].present? ? params[:id] : params[:pre_bill_id]
      @bill = Bill.find(id)
    end

    def load_sale
      @sale = Shipment.find_by_folio(params[:sale])
    end

    def load_sale_by_id(id)
      @sale = Shipment.find(id)
    end

    def filters
      search_by_serie if params[:serie].present?
      search_by_client if params[:client].present?
      search_by_status if params[:status].present?
      return unless params[:dates].present?

      if params[:dates][:from_date].present? && params[:dates][:to_date].present?
        search_by_dates
      end
    end

    def search_by_serie
      @pre_bills = @pre_bills.where('serie ~* ?', @serie)
    end

    def search_by_client
      @pre_bills = @pre_bills.where(client_id: @client)
    end

    def search_by_status
      @pre_bills = @pre_bills.where(status: @status)
    end

    def search_by_dates
      @pre_bills = @pre_bills.where(pre_billed_at: @from_date..@to_date)
    end

    def set_form_params
      @serie = params[:serie].present? ? params[:serie] : nil
      @client = params[:client].present? ? params[:client] : nil
      @status = params[:status].present? ? params[:status] : nil
      @from_date, @to_date = nil

      return unless params[:dates].present?
      unless params[:dates][:from_date].present? && params[:dates][:to_date].present?
        return
      end

      @from_date = Date.parse(params[:dates][:from_date]).beginning_of_day
      @to_date = Date.parse(params[:dates][:to_date]).end_of_day
    end
  end
end
