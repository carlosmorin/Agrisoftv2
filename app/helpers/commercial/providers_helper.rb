module Commercial::ProvidersHelper
  def cfdi_usage(code)
    Sat::CfdiUsage.find_by_code(code).description
  end

  def payment_method(code)
    Sat::PaymentMethod.find_by_code(code).description
  end

  def payment_mean(code)
    Sat::PaymentMean.find_by_code(code).description
  end
end