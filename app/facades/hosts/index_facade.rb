module Hosts
  class IndexFacade
    attr_reader :hosts

    def initialize(params)
      @params = params
      get_hosts
    end

    def get_hosts
      @hosts = Host.paginate(page: @params[:page], per_page: 20)
      search if @params[:q].present?
    end

    private

    def search
      q = Regexp.escape(@params[:q])
      @hosts = @hosts.where("concat(name) ~* ?", q)
    end
  end
end
