import { Controller } from "stimulus"
const Axios = require('axios');
const toastr = require('toastr');

export default class extends Controller {
  static targets = [ "output", 'saleId' ]
  connect() {
 		console.log("Files controller")
  }

  saveDocuments(e){
    e.preventDefault()
    const url = `/crm/sales/${this.saleIdTarget.value}/documents`
    var form = e.currentTarget
    var formData = new FormData(form);
    var _this = this
    Axios({
      method: 'PATCH',
      url: url,
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
      data: formData
    })
    .then(function (response) {
      console.log(response['status'])
      if (response['status'] == 204 || response['status'] == 200) {
        toastr.success('Operación realizada con exito!', {timeOut: 1000})
        setTimeout(function(){
  				Turbolinks.visit(window.location, { action: 'replace' })
  			}, 500);
      }
    });
  }
}