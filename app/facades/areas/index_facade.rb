# frozen_string_literal: true

module Areas
  class IndexFacade
    attr_reader :areas

    def initialize(params)
      @params = params
      get_areas
    end

    def get_areas
      @areas = Area.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @areas = @areas.joins(:ranch, :irrigation_type).where("concat(areas.name, ' ', areas.territory, ' ', ranches.name, ' ', irrigation_types.name) ~* ?", q)
    end
  end
end
