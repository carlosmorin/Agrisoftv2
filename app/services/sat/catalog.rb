# frozen_string_literal: true

require 'spreadsheet'

module Sat
  # This class returns the SAT catalogs
  class Catalog
    class << self
      def contents(tab_name, start_index, number_columns, zero_padding)
        content = []

        open_tab(tab_name).each_with_index do |row, index|
          next unless index >= start_index
          break if row[0].nil?

          row_content = []
          j = row[0]
          j = j.to_int.to_s.rjust(zero_padding, '0') if j.is_a? Numeric
          row_content.push(j)

          (1..number_columns).each { |i| row_content.push(row[i]) }
          content.push(row_content)
        end
        content
      end

      def open_tab(tab_name)
        file_path = File.join(File.dirname(__FILE__), '../../../catCFDI.xls')
        book = Spreadsheet.open(file_path)
        book.worksheet(tab_name)
      end

      def fee
        contents('c_TasaOCuota', 6, 6, 0)
      end

      def customs
        contents('c_Aduana', 5, 1, 2)
      end

      def factor_types
        contents('c_TipoFactor', 5, 1, 0)
      end

      def measure_units
        contents('c_ClaveUnidad', 6, 6, 0)
      end

      def product_service
        contents('c_ClaveProdServ', 4, 8, 0)
      end

      def zip_code_first_half
        contents('c_CodigoPostal_Parte_1', 5, 3, 0)
      end

      def zip_codes
        zip_code_first_half + contents('c_CodigoPostal_Parte_2', 5, 3, 0)
      end

      def payment_means
        contents('c_FormaPago', 6, 1, 2)
      end

      def taxes
        contents('c_Impuesto', 5, 4, 3)
      end

      def payment_methods
        contents('c_MetodoPago', 5, 1, 0)
      end

      def currency
        contents('c_Moneda', 5, 2, 0)
      end

      def country
        contents('c_Pais', 5, 5, 0)
      end

      def customs_patent_code
        contents('c_NumPedimentoAduana', 5, 3, 2)
      end

      def customs_patent
        contents('c_PatenteAduanal', 5, 1, 4)
      end

      def fiscal_regimes
        contents('c_RegimenFiscal', 6, 3, 0)
      end

      def voucher_type
        contents('c_TipoDeComprobante', 5, 1, 0)
      end

      def relationship_type
        contents('c_TipoRelacion', 5, 1, 2)
      end

      def cfdi_usages
        contents('c_UsoCFDI', 6, 3, 0)
      end

      def custom_measure_units
        contents('c_UnidadAduana', 5, 1, 0)
      end

      def tariff_fractions
        contents('c_FraccionArancelaria', 6, 7, 0)
      end

      def international_commercial_terms
        contents('c_INCOTERM', 5, 1, 0)
      end

      def request_keys
        contents('c_ClavePedimento', 5, 1, 0)
      end

      def neighborhoods
        contents('c_Colonia_1', 5, 2, 0)
        contents('c_Colonia_2', 5, 2, 0)
        contents('c_Colonia_3', 5, 2, 0)
      end

      def locations
        contents('c_Localidad', 5, 2, 0)
      end

      def municipalities
        contents('c_Municipio', 5, 2, 0)
      end

      def states
        contents('c_Estado', 5, 2, 0)
      end

      def operation_types
        contents('c_TipoOperacion', 5, 1, 0)
      end

      def transfer_means
        contents('c_MotivoTraslado', 5, 1, 0)
      end
    end
  end
end
