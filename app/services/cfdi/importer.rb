# frozen_string_literal: true

# class to import cfdi fields from external xml
module Cfdi
  # methods to obtain external cfdi data
  class Importer < Verifier
    def self.call(source_xml)
      new(source_xml).call
    end

    def initialize(source_xml)
      @source_xml = source_xml
    end

    def call
      return invalid_xml_error unless a_xml?

      set_import_global_variables
      return build_response(error: 'XML inválido') if @xml.errors.any?

      return error_response unless @receiver.present? && @business.present?

      set_cfdi_nodes_variables
      build_response
    end

    private

    def build_response(error: nil)
      { 'invoice' => invoice_fields, 'errors' => error }
    end

    def cdfi_fields
      {
        folio: @cdfi_node.attr('Folio'), serie: @cfdi_node.attr('Serie'),
        seal: @cfdi_node.attr('Sello'),
        certificate_number: @cfdi_node.attr('NoCertificado'),
        payment_mean: @cfdi_node.attr('FormaPago'),
        payment_method: @cfdi_node.attr('MetodoPago'),
        currency: @cfdi_node.attr('Moneda'),
        currency_exchange_rate: @cfdi_node.attr('TipoCambio')
      }
    end

    def sat_fields
      {
        stamped_at: @sat_seal_node.attr('FechaTimbrado'),
        uuid: @sat_seal_node.attr('UUID'),
        sat_seal: @sat_seal_node.attr('SelloSAT'),
        sat_certificate_number: @sat_seal_node.attr('NoCertificadoSAT'),
        stamped_invoice: @xml.to_xml,
        original_string:
          Cfdi::Original.sat_xslt.transform(@xml, %w[key value]).to_str
      }
    end

    def invoice_fields
      return if @xml.errors.any?

      return if @cfdi_node.nil? || @sat_seal_node.nil?

      cfdi_fields.merge(sat_fields)
    end
  end
end
