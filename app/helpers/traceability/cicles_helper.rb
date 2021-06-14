module Traceability::CiclesHelper
	def cicle_status(status)
  	return '<span class="badge bg-secondary">Inactivo</span>' if status.eql?('inactive')
  	return '<span class="badge bg-success">Activo</span>' if status.eql?('active')
	end

	def cicle_area_status(status)
  	return '<span class="badge bg-secondary">Ocupado</span>' if status.eql?('busy')
  	return '<span class="badge bg-success">Disponible</span>' if status.eql?('available')
	end
end