module Pests
  class PestDecorator < SimpleDelegator
    def display_pictures
      urls = pictures.map {|pic| pic.service_url }
      html = ""
      (0...pictures.count).each_with_index do |picture, i|
        html += "<div class='col-lg-2 text-left'>
          <img src='#{urls[i]}'  class='rounded img-thumbnail mb-2'/>
        </div>"
      end
      html.html_safe
    end
  end
end