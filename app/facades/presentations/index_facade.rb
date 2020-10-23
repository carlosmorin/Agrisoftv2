module Presentations
  class IndexFacade
    attr_reader :presentations

    def initialize(params)
      @params = params
      get_presentations
    end

    def get_presentations
      @presentations = Presentation.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @presentations = @presentations.where("concat(name, ' ', price, ' ', quantity) ~* ?", q)
    end
  end
end
