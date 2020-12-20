# frozen_string_literal: true

module EnumsHelper
  def client_types_es
    { 'NACIONAL' => 'national', 'INTERNACIONAL' => 'international' }
  end

  def pay_freights_es
    { 'CLIENTE' => 'client', 'REMISIONISTA' => 'company', 'NINGUNO' => 'no_one' }
  end

  def date_due_es
    { 'VENTA' => 'sale', 'FACTURA' => 'bill' }
  end
end
