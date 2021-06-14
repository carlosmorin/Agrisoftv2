module Traceability
  class HarvestsController < ApplicationController
    before_action :set_object, only: %i[show edit update]
    before_action :set_collections, only: %i[new edit]

    def index
      @harvests = Harvest.all.order(:created_at)
      filter_by_query if params[:query]
      @harvests = @harvests.paginate(page: params[:page], per_page: 20)
    end

    def new
      @harvest = Harvest.new
    end

    def create
      @harvest = Harvest.new(harvest_params)
      if @harvest.save
        flash[:notice] = "<i class='fa fa-check-circle mr-2'></i> Registro de cosecha creada exitosamente"
        redirect_to traceability_harvest_path(@harvest)
      else
        set_collections
        render :new
      end
    end

    def update
      if @harvest.update(harvest_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-2'></i> Registro de cosecha actualizado"
        redirect_to traceability_harvest_path(@harvest)
      else
        set_collections
        render :edit
      end
    end

    def get_crop
      area = CiclesArea.currents.where(area_id: params[:area_id])
      crop = area.last.cicle.crop
      render json: crop
    end
    private

    def filter_by_query
      query = Regexp.escape(params[:query])

      @harvests = @harvests.where("folio ~* ?", query)
    end

    def set_collections
      @areas = CiclesArea.currents.joins(:area).select('areas.id, areas.name').uniq
      @crops = Crop.all.pluck(:name, :id)
      @production_units = ProductionUnit.all
    end

    def set_object
      @harvest = Harvest.find(params[:id])
    end    

    def harvest_params
      params.require(:harvest).permit(
        :id, :harvest_at, :responsable, :tractor_identifier, :tractor_driver, 
        :status, :folio, :comments, :_destroy, 
        harvest_logs_attributes: [:id, :crop_id, :area_id, :production_unit_id, 
          :n_items, :harvest_id, :_destroy]
      )
    end
  end
end