module ApplicationHelper
	def config?
    controller.class.name.split("::").first=="Config"
  end

  def current_link?(path)
	  "active" if request.url.include?(path)
	end
end
