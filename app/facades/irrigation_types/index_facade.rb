module IrrigationTypes
  class IndexFacade
    attr_reader :irrigation_types

    def initialize(params)
      @params = params
      get_irrigation_types
    end

    def get_irrigation_types
      @irrigation_types = IrrigationType.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @irrigation_types = @irrigation_types.where("concat(name) ~* ?", q)
    end
  end
end
