# frozen_string_literal: true

class Pests::IndexFacade
  attr_reader :pests

  def initialize(params)
    @params = params
    get_pets
  end

  def get_pets
    @pests = Pest.paginate(page: @params[:page], per_page: 10)
    search if @params[:q].present?
  end

  private

  def search
    q = Regexp.escape(@params[:q])
    @pests = @pests.where("concat(name, ' ', scientific_name) ~* ?", q)
  end
end
