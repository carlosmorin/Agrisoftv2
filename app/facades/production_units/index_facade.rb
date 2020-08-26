module ProductionUnits
  class IndexFacade
    attr_reader :production_units

    def initialize(params)
      @params = params
      get_production_units
    end

    def get_production_units
      @production_units = ProductionUnit.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @production_units = @production_units.where("concat(name) ~* ?", q)
    end
  end
end
