import { Controller } from "stimulus"
const axios = require('axios');
const toastr = require('toastr');

export default class extends Controller {
  static targets = [ 'saleId', 'currencyId', 'exchangeRate' ]
  connect() {
 		// console.log("Currency controller")
  }

  updateCurrency(e){
    e.preventDefault()
  	var saleId = this.saleIdTarget.value
  	var currencyId = this.currencyIdTarget.value
    var exchangeRate = this.exchangeRateTarget.value
		var url = `/crm/sales/${saleId}/update_currency`
    console.log('updateCurrency', url)
		
		axios({
			method: 'patch',
		  url: url,
		  headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
		  data: { sale_id: saleId, currency_id: currencyId, exchange_rate: exchangeRate }
		})
		.then(function (response) {
    	if (response['status'] == 204) {
    		$('#currencyModal').modal('hide')
    		toastr.success('Operación realizada con exito!', {timeOut: 500})
        setTimeout(function(){ 
        	Turbolinks.visit(window.location, { action: 'replace' }) 
        }, 500);
    	}
  	});
  }

  setExchangeRate(){
    let currency = this.currencyIdTarget.value
    if (currency == 1) {
      this.exchangeRateTarget.value = '1'
    }else{
      this.exchangeRateTarget.value = null
    }
  }
}