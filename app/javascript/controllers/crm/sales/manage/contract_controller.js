import { Controller } from "stimulus"
const axios = require('axios');
const toastr = require('toastr');

export default class extends Controller {
  static targets = [ 'output', 'saleId', 'contractId', 'contractExchange' ]
  connect() {
 		console.log("Contract controller")
  }

  linkContract(e){
    e.preventDefault()
  	var sale_id = this.saleIdTarget.value
  	var contract_id = this.contractIdTarget.value
		var url = `/crm/sales/${sale_id}/set_contract`
		
		axios({
			method: 'patch',
		  url: url,
		  headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
		  data: { sale_id: sale_id, contract_id: contract_id }
		})
		.then(function (response) {
    	if (response['status'] == 204) {
    		$('#acModal').modal('hide')
    		toastr.success('Operación realizada con exito!', {timeOut: 500})
        setTimeout(function(){ 
        	Turbolinks.visit(window.location, { action: 'replace' }) 
        }, 500);
    	}
  	});
  }
}