class Treatments::IndexFacade 
  attr_accessor :treatments

  def initialize(params)
    @params = params
    get_treatments
  end

  def get_treatments
    @treatments = Treatment.paginate(page: 1, per_page: @params[:page])
    search if @params[:q]
  end

  private

  def search
    q = Regexp.escape(@params[:q])
    @treatments = @treatments.join(treatments_supply: [:supply]).where("concat(supplies.name), ~* ?", q)
  end
end