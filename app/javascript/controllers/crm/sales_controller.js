import { Controller } from "stimulus"
import swal from 'sweetalert';
const Axios = require('axios');
const toastr = require('toastr');

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
  }

  confirmCancelSale(event){
    event.preventDefault();
    var saleNumber = event.currentTarget.getAttribute('data-saleNumber')
    var sale_id = event.currentTarget.getAttribute('data-id')
    var cancel = event.currentTarget.getAttribute('data-cancel')
    swal({
      title: "Requiere confirmación!",
      text: `Deseas cambiar el estatus de la venta ${saleNumber} ?`,
      buttons: true,
      buttons: ['Cancelar', 'Aceptar']
    })
    .then((willDelete) => {
      if (willDelete) {
        this.cancelSale(sale_id, cancel)
      } 
    });
  }

  cancelSale(id, cancel){
    var url = `sales/${id}/cancel`
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

  validQuantity(){
    console.log("validQuantity")
  }
}