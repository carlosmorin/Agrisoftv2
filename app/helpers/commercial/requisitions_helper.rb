module Commercial::RequisitionsHelper
  def priority(priority)
    if priority.eql?('normal')
      '<span class="badge bg-primary">NORMAL</span>'
    elsif priority.eql?('hight')
      '<span class="badge bg-warning text-dark">ALTA</span>'
    elsif priority.eql?('urgent')
      '<span class="badge bg-danger">URGENTE</span>'
    end
  end

  def status(req)
    status = req.status
  	return '<span class="badge bg-success">AUTORIZADA</span>' if status.eql?('authorized')
    return '<span class="badge bg-danger">CANCELADA</span>' if status.eql?('canceled')
    return '<span class="badge bg-warning">EXPIRADA</span>' if req.limit_at < Time.zone.now
    return '<span class="badge bg-secondary">SIN AUTORIZAR</span>' if status.eql?('unauthorized')
  end
end