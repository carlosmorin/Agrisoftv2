import { Controller } from "stimulus"
import swal from 'sweetalert';
const axios = require('axios');

export default class extends Controller {
  connect(){
    console.log('Show controller')
  }

  confirm(e){
    e.preventDefault();
    console.log("confirm")
    this.url = e.currentTarget.getAttribute('href')

    swal({
      title: "Requiere confirmación!",
      text: `Deseas aprobar esta acción?`,
      buttons: true,
      buttons: ['Cancelar', 'Aceptar']
    })
    .then((willDelete) => {
      if (willDelete) {
        this.updateStatus()
      } 
    });
  }

  updateStatus(){
    axios({
      method: 'patch',
      url: this.url,
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