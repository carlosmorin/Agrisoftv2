# frozen_string_literal: true

class Deseases::IndexFacade
  attr_reader :deseases

  def initialize(params)
    @params = params
    get_deseases
  end

  def get_deseases
    @deseases = Desease.paginate(page: @params[:page], per_page: 10)
    search if @params[:q].present?
  end

  private

  def search
    q = Regexp.escape(@params[:q])
    @deseases = @deseases.where("concat(name, ' ', scientific_name, ' ', pathogen) ~* ?", q)
  end
end
