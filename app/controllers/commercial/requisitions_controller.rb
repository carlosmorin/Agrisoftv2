module Commercial
  class RequisitionsController < ApplicationController
    before_action :set_object, only: %i[show edit update destroy]
    def index
    	@requisitions = Requisition.paginate(page: params[:page], per_page: 25)
    end

    def new
    	@requisition = Requisition.new
    end

    def create
      @requisition = Requisition.new(requisition_params)
      respond_to do |format|
        if @requisition.save
          format.html do
            redirect_to commercial_requisition_url(@requisition),
                        notice: 'La requisición fue guardada con exito.'
          end
        else
          format.html { render :new }
        end
      end
    end

    private

    def requisition_params
      params.require(:requisition).permit(:id, :user_id, :department, :folio,
				:comments, :limit_at, :priority, :status, 
        requisitions_supplies_attributes:[ 
          :id, :requisition_id, :supply_id, :unit_measure_id, :supply, :status,
          :quantity, :created_at, :_destroy
        ]
      )
    end

  	def set_object
    	id = params[:id].present? ? params[:id] : params[:requisition_id]

    	@requisition = Requisition.find(id)
  	end
  end
end