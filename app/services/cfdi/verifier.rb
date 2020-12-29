# frozen_string_literal: true

module Cfdi
  # base methods to import external xml
  class Verifier
    protected

    attr_reader :source_xml
    def a_xml?
      ext = source_xml['external_xml'].content_type.split('/')
      %w[xml].include?(ext[1])
    end

    def invalid_xml_error
      build_response(error: 'Archivo no permitido')
    end

    def read_xml
      Nokogiri::XML(File.open(source_xml['external_xml'].tempfile).read)
    end

    def obtain_receiver
      cfdi_receiver = @cfdi_node.xpath('//cfdi:Receptor')
      rfc = value(cfdi_receiver.attr('Rfc'))
      name = value(cfdi_receiver.attr('Nombre'))
      Fiscal.find_by(rfc: rfc, bussiness_name: name).fiscalable
    end

    def obtain_business
      cfdi_business = @cfdi_node.xpath('//cfdi:Emisor')
      rfc = value(cfdi_business.attr('Rfc'))
      Company.find_by(rfc: rfc)
    end

    def complement_node
      @complement_node ||= @cfdi_node.xpath('.//cfdi:Complemento').first
    end

    def find_complement(complement_name)
      node = nil
      @complement_node.elements.each do |e|
        next unless e.name == complement_name

        node = e
      end
      node
    end

    def find_node(node_name)
      node = nil
      @cfdi_node.first.elements.each do |e|
        next unless e.name == node_name

        node = e
      end
      node
    end

    def sat_seal_node
      @sat_seal_node ||= find_complement('TimbreFiscalDigital')
    end

    def document_legends_node
      @document_legends_node ||= find_complement('LeyendasFiscales')
    end

    def payment_node
      @payment_node ||= find_complement('Pagos').xpath('.//pago10:Pago')
    end

    def cfdi_node
      @cfdi_node ||= @xml.xpath('//cfdi:Comprobante')
    end

    def set_cfdi_nodes_variables
      complement_node
      sat_seal_node
    end

    def error_response
      return build_response(error: 'Receptor no registrado') if @receiver.nil?

      return build_response(error: 'Emisor no registrado') if @business.nil?
    end

    def set_import_global_variables
      @xml = read_xml
      return if @xml.errors.any?

      cfdi_node
      @receiver = obtain_receiver
      @business = obtain_business
      # @model = model(@cfdi_node.attr('TipoDeComprobante'))
    end

    def value(attr)
      attr.try(:value) || attr
    end

    #  Uncomment when stamp functionality is allready done
    # def model(voucher_type)
    #   type =  voucher_type.is_a?(Object) ? voucher_type.value : voucher_type
    #   case type
    #   when 'T' then Sinetti::BearingLetter
    #   when 'E' then Sinetti::Expenditure
    #   when 'I' then Sinetti::Income
    #   when 'P' then Sinetti::Payment::Voucher
    #   else Sinetti::Invoice
    #   end
    # end
    #
    # def set_object
    #   @object = @model.new(imported: true,
    #                        status: @model.statuses[:stamped],
    #                        type: @model.name)
    # end
  end
end
