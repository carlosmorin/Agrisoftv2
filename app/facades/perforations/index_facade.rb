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
      @perforations = @perforations.where("concat(name, ' ', coordinates, ' ', registry_number) ~* ?", q)
    end
  end
end
