# frozen_string_literal: true

require 'net/http'
module Cfdi
  # class used to obtain the SAT CADENA ORIGINAL XSLT
  class OriginalString
    def self.sat_xslt
      url = 'http://www.sat.gob.mx/sitio_internet/cfd/3/cadenaoriginal_3_3/cadenaoriginal_3_3.xslt'
      Nokogiri::XSLT(HTTParty.get(url).body)
    end
  end
end
