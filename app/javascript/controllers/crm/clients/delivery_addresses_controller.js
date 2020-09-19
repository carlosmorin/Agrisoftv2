import { Controller } from "stimulus"
const Axios = require('axios');
const toastr = require('toastr');

export default class extends Controller {
  static targets = [ "form" ]

  connect(){
    console.log("delivery_addresses_controller")
  }

  savePrices(e){
    e.preventDefault()
    const url = "/crm/delivery_addresses/update_prices"
    var data = $(this.formTarget).serialize()
    console.log("Data", data)

    Axios({
      method: 'PATCH',
      url: url,
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
      data: data
    })
		.then(function (response) {
			if (response['status'] == 204) {
				toastr.options.preventDuplicates = true;
				toastr.options.closeButton = true;
				toastr.success('Operación realizada con exito!', {timeOut: 2000})
    	}
		});
  }
}
