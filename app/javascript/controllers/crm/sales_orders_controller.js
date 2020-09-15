import { Controller } from "stimulus"
const Axios = require('axios');
const toastr = require('toastr');

export default class extends Controller {
  static targets = [ "appoinmentContainer" ]

  connect() {
  	console.log(this.appoinmentContainerTarget)
  }

  toggleAppoinmentContainer(e){
  	if (e.currentTarget.checked) {
  		this.appoinmentContainerTarget.classList.remove('d-none')
  	}else{
  		this.appoinmentContainerTarget.classList.add('d-none')
  	}
  }

 confirmCancelOV(e){
    e.preventDefault()
    var ovNumber = e.currentTarget.getAttribute('data-ovNumber')
    var ov_id = e.currentTarget.getAttribute('data-id')
    var cancel = e.currentTarget.getAttribute('data-cancel')
    var msg = ''
    if (cancel == '0') {
      msg = 'Deseas activar la Orden de venta'
    }else{
      msg = 'Deseas cancelar la Orden de venta'
    }
    swal({
      title: "Requiere confirmación!",
      text: `${msg} ${ovNumber}?`,
      buttons: true,
      buttons: ['Cancelar', 'Aceptar']
    })
    .then((willDelete) => {
      if (willDelete) {
        this.cancelOV(ov_id, cancel)
      } 
    });
  }

  cancelOV(id, cancel){
    var url = `/crm/sales_orders/${id}/cancel`
    Axios({
      method: 'patch',
      url: url,
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
      data: { cancel: cancel }
    })
    .then(function (response) {
      if (response['status'] == 204) {
        toastr.success('Operación realizada con exito!', {timeOut: 1000})
        setTimeout(function(){ Turbolinks.visit(window.location, { action: 'replace' }) }, 1000);
      }
    });
  }
}
