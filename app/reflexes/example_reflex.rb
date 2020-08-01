# frozen_string_literal: true

class ExampleReflex < ApplicationReflex
  def form
    binding.pry
    @box = BoxType.new(name: element[:value])
    @box.valid?
  end
end
