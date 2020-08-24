class Search
  def initialize(options, scope)

  end

  def custom_search
    q = Regexp.escape(@params[:q])
    @perforations = @perforations.where("concat(name, ' ', coordinates, ' ', registry_number) ~* ?", q)
  end
end