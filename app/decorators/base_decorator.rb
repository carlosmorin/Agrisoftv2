# frozen_string_literal: true

class BaseDecorator < SimpleDelegator
  def display_pictures
    urls = pictures.map(&:service_url)
    html = ''
    (0...pictures.count).each_with_index do |_picture, i|
      html += "<div class='col-lg-4 text-left'>
        <img src='#{urls[i]}'  class='rounded img-thumbnail mb-2'/>
      </div>"
    end
    html.html_safe
  end

  def display_errors
    errors.full_messages.map { |error| "<p>#{error}</p>" }.join('')
  end
end
