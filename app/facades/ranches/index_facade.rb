module Ranches
  class IndexFacade
    attr_reader :ranches

    def initialize(params)
      @params = params
      get_ranches
    end

    def get_ranches
      @ranches = Ranch.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @ranches = @ranches.where("concat(state, ' ', city, ' ', territory) ~* ?", q)
    end
  end
end
