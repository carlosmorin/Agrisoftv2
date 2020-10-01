module EnumsHelper
  def client_types_es
  	{"NACIONAL"=>'national', "INTERNACIONAL"=>'international'}
  end

  def pay_freights_es
  	{"CLIENTE"=>'client', "REMISIONISTA"=>'company', "NINGUNO"=>'no_one'}
  end
end