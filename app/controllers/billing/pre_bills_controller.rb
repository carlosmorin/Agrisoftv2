module Billing
  class PreBillsController < ApplicationController
    before_action :set_bill, only: [:show, :edit, :update, :destroy]
    add_breadcrumb "Facturación"
    add_breadcrumb "Pre facturas"

    def index
      @pre_bills = Bill.pre_bills
    end

    def show
    end

    # GET /rooms/new
    def new  
      build_prebill if params[:sale].present?
      @pre_bill = Bill.new()
    end

    # GET /rooms/1/edit
    def edit
    end

    # POST /rooms
    # POST /rooms.json
    def create
      @pre_bill = Bill.new(room_params)

      respond_to do |format|
        if @room.save
          format.html { redirect_to @room, notice: 'Room was successfully created.' }
          format.json { render :show, status: :created, location: @room }
        else
          format.html { render :new }
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /rooms/1
    # PATCH/PUT /rooms/1.json
    def update
      respond_to do |format|
        if @room.update(room_params)
          format.html { redirect_to @room, notice: 'Room was successfully updated.' }
          format.json { render :show, status: :ok, location: @room }
        else
          format.html { render :edit }
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end
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

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_room
        @room = Room.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def room_params
        params.require(:room).permit(:name)
      end

      def build_prebill
        load_sale
      end

      def load_sale
        @sale = Shipment.find_by_folio(params[:folio])
      end
  end

end
