# frozen_string_literal: true

module Traceability
  class AreasController < ApplicationController
    before_action :set_object, only: %i[show]

  	def index
  		@areas = CiclesArea.all.order(:created_at)
      filter_by_query if params[:query]
      @areas = @areas.paginate(page: params[:page], per_page: 16)
  	end

  	private

  	def set_object
			@area = CiclesArea.find(params[:id])
  	end

    def filter_by_query
      query = Regexp.escape(params[:query])

      @areas = @areas.where("name ~* ?", query)
    end
  end
end