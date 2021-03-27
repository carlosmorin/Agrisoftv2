module Commercial
  class RequisitionsController < ApplicationController
    before_action :set_object, only: %i[show edit update destroy print update_status]

    add_breadcrumb 'Comercial', :commercial_root_path
    add_breadcrumb 'Requisiciónes', :commercial_requisitions_path

    def index
      @requisitions = Requisition.paginate(page: params[:page], per_page: 25)

      filters
    end

    def new
      @requisition = Requisition.new
      @requisition.requisitions_supplies.build
    end

    def create
      @requisition = Requisition.new(requisition_params)
      if @requisition.save
          flash[:notice] = 'La requisición fue guardada con exito.'
          redirect_to commercial_requisition_url(@requisition)
      else
        render :new
      end
    end

    def update
      if @requisition.update(requisition_params)
        flash[:notice] = "La requisición fue actualizada con exito."
        redirect_to commercial_requisition_url(@requisition)
      else
        render :edit
      end
    end

    def print
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Requisición N° #{@requisition.folio}",
                 page_size: 'A4',
                 template: 'commercial/requisitions/print.html.slim',
                 layout: 'pdf.html',
                 lowquality: true,
                 zoom: 1,
                 dpi: 75
        end
      end
    end

    def update_status
      @requisition.update(status: params[:status], "#{params[:status]}_at": Time.zone.now )
    end

    private

    def filters
      search if params[:query].present?
      filter_by_status if params[:status].present?
      filter_by_priority if params[:priority].present?
      filter_by_dates if params[:dates].present?
    end

    def filter_by_dates
      dates = params[:dates].split(' - ')
      from = Date.parse(dates.first).beginning_of_day
      to = Date.parse(dates.last).end_of_day
      @requisitions = @requisitions.where(limit_at: from..to)
    end

    def search
      q = Regexp.escape(params[:query])

      @requisitions = @requisitions.where("concat(department, ' ', folio, ' ', comments) ~* ?", q)
    end

    def filter_by_status
      status = Regexp.escape(params[:status])
      
      return expired_collection if status.eql?('expired')
      @requisitions = @requisitions.where(status: status)
      @requisitions = @requisitions.currents if status.eql?('unauthorized')
    end

    def filter_by_priority
      priority = Regexp.escape(params[:priority])
      @requisitions = @requisitions.where(priority: priority)
    end

    def filter_unauthorized
      @requisitions = @requisitions.where(status: status)
    end

    def expired_collection
      @requisitions = @requisitions.where(status: 'unauthorized').expired
    end

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