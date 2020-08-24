module Stages
  class IndexFacade
    attr_reader :stages

    def initialize(params)
      @params = params
      get_stages
    end

    def get_stages
      @stages = Stage.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @stages = @stages.where("concat(name, ' ') ~* ?", q)
    end
  end
end
