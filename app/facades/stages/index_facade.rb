# frozen_string_literal: true

module Stages
  class IndexFacade
    attr_reader :stages, :stage

    def initialize(params)
      @params = params
      get_stages
    end

    def get_stages
      @stages = Stage.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    def find_stage(id)
      @stage = Stage.find(id)
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @stages = @stages.where("concat(name, ' ') ~* ?", q)
    end
  end
end
