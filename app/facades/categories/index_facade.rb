module Categories
  class IndexFacade
    attr_reader :categories

    def initialize(params)
      @params = params
      get_categories
    end

    def get_categories
      @categories = Category.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @categories = @categories.where("concat(name) ~* ?", q)
    end
  end
end
