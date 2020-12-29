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

    def cfdi_fields
      {
        sat_folio: value(@cfdi_node.attr('Folio')),
        sat_serie: value(@cfdi_node.attr('Serie')),
        certificate: value(@cfdi_node.attr('Certificado')),
        seal: value(@cfdi_node.attr('Sello')),
        certificate_number: value(@cfdi_node.attr('NoCertificado'))
      }
    end

    def sat_fields
      {
        stamped_at: value(@sat_seal_node.attr('FechaTimbrado')),
        uuid: value(@sat_seal_node.attr('UUID')),
        sat_seal: value(@sat_seal_node.attr('SelloSAT')),
        sat_certificate_number: value(@sat_seal_node.attr('NoCertificadoSAT')),
        stamped_invoice: @xml.to_xml,
        original_string:
          Cfdi::OriginalString.sat_xslt.transform(@xml, %w[key value]).to_str
      }
    end

    def payment_fields
      {
        total: value(@cfdi_node.attr('Total')),
        sat_payment_mean: value(@cfdi_node.attr('FormaPago')),
        sat_payment_method: value(@cfdi_node.attr('MetodoPago')),
        sat_currency: value(@cfdi_node.attr('Moneda')),
        sat_currency_exchange_rate: value(@cfdi_node.attr('TipoCambio'))
      }
    end

    def invoice_fields
      return if @xml.errors.any?

      return if @cfdi_node.nil? || @sat_seal_node.nil?

      cfdi_fields.merge(payment_fields.merge(sat_fields))
    end
  end
end
