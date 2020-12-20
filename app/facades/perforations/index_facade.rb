# frozen_string_literal: true

module Perforations
  class IndexFacade
    attr_reader :perforations

    def initialize(params)
      @params = params
      get_perforations
    end

    def get_perforations
      @perforations = Perforation.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @perforations = @perforations.joins(:ranch).where("concat(perforations.name, ' ', perforations.coordinates, ' ', perforations.registry_number, ' ', ranches.name) ~* ?", q)
    end
  end
end
