import { Controller } from "stimulus"
const Axios = require('axios');
const toastr = require('toastr');
import swal from 'sweetalert';

export default class extends Controller {
  static targets = []

  initialize() {
  }

  cancel(e){
  	let folio = e.currentTarget.getAttribute('data-folio') 
  	let id = e.currentTarget.getAttribute('data-id') 
    swal({
      title: 'Requiere confirmación!',
      text: `Deseas cancelar la factura con folio: ${ folio }`,
      buttons: true,
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {
				let url = `/billing/pre_bills/${id}/cancel`
				Axios({
					method: 'PATCH',
					url: url,
      		headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
      		data: {'cancel': true}
				})
				.then(function (response) {
        	toastr.success('Operación realizada con exito!', {timeOut: 1000})
        	setTimeout(function(){ Turbolinks.visit(window.location, { action: 'replace' }) }, 1000);
				});	
      }
    });
  }

}