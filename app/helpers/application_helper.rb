module ApplicationHelper
	def config?
    controller.class.name.split("::").first=="Config"
  end
end
