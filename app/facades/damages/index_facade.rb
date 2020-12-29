# frozen_string_literal: true

module Damages
  class IndexFacade
    attr_reader :damages

    def initialize(params)
      @params = params
      get_damages
    end

    def get_damages
      @damages = Damage.paginate(page: @params[:page], per_page: 20)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @damages = @damages.where('concat(name) ~* ?', q)
    end
  end
end
