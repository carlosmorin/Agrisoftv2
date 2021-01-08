import { Controller } from "stimulus"
import swal from 'sweetalert';
const Axios = require('axios');

export default class extends Controller {
  initialize() {
  }

  confirm(e){
  	e.preventDefault()
  	let url = e.currentTarget.getAttribute('href')
  	swal({
      title: "Requiere confirmación!",
      text: `Deseas desactivar este proveedor?`,
      buttons: true,
      buttons: ['Cancelar', 'Aceptar']
    })
    .then((willDelete) => {
      if (willDelete) {
        this.updateStatus(url)
      } 
    });
  }

  updateStatus(url){
    Axios({
      method: 'patch',
      url: url,
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')}
    })
    .then(function (response) {
      if (response['status'] == 204) {
        toastr.success('Operación realizada con exito!', {timeOut: 1000})
        setTimeout(function(){ Turbolinks.visit(window.location, { action: 'replace' }) }, 1000);
      }
    });
  }
}