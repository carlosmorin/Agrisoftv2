import { Controller } from "stimulus"
const Axios = require('axios');

export default class extends Controller {
  initialize() {
  	console.log("Im here")
  }

  confirmDeleteItem(e){
  	e.preventDefault()
  	let url = e.currentTarget.getAttribute('href')

  	swal({
      title: "Requiere confirmación!",
      text: `Deseas eliminar este producto del catalogo de productos?`,
      buttons: true,
      buttons: ['Cancelar', 'Aceptar']
    })
    .then((willDelete) => {
      if (willDelete) {
        this.deleteItem(url)
      } 
    });
  }

  deleteItem(url){
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