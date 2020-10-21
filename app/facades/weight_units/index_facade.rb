module WeightUnits
  class IndexFacade
    attr_reader :weight_units

    def initialize(params)
      @params = params
      get_weight_units
    end

    def get_weight_units
      @weight_units = WeightUnit.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @weight_units = @weight_units.where("concat(name) ~* ?", q)
    end
  end
end
