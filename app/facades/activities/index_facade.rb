# frozen_string_literal: true

module Activities
  class IndexFacade
    attr_reader :activities

    def initialize(params)
      @params = params
      get_activities
    end

    def get_activities
      @activities = Activity.paginate(page: @params[:page], per_page: 10)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @activities = @activities.where('concat(action) ~* ?', q)
    end
  end
end
