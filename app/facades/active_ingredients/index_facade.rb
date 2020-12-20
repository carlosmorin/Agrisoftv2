# frozen_string_literal: true

module ActiveIngredients
  class IndexFacade
    attr_reader :active_ingredients

    def initialize(params)
      @params = params
      get_active_ingredients
    end

    def get_active_ingredients
      @active_ingredients = ActiveIngredient.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @active_ingredients = @active_ingredients.where('concat(name) ~* ?', q)
    end
  end
end
