module Api::Services
  class SuppliesController < ApplicationController
    def index
      @supplies = Supply.all
      search if params[:query].present?
      render json: @supplies
    end

    private

    def search
      q = Regexp.escape(params[:query])

      @supplies = @supplies.where('name ~* ?', q)
    end
  end
end