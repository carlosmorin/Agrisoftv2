module SubStages
  class IndexFacade
    attr_reader :sub_stages

    def initialize(params)
      @params = params
      get_sub_stages
    end

    def get_sub_stages
      @sub_stages = SubStage.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @sub_stages = @sub_stages.where("concat(name, ' ') ~* ?", q)
    end
  end
end
