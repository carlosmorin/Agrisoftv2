import { Controller } from "stimulus"
import swal from 'sweetalert';
const Axios = require('axios');
const toastr = require('toastr');

export default class extends Controller {
  static targets = ['row', 'selectAll', 'checkQuote', 'consolidateButton']

  initialize() {
  }

  confirmOrderSale(event){
    event.preventDefault();
    var current_element = event.currentTarget
    var itemId = current_element.getAttribute('data-id')
    var rowPosition = current_element.getAttribute('data-position')
    var quoteNumber = current_element.getAttribute('data-quoteNumber')
    swal({
      title: "Requiere confirmación!",
      text: `Deseas convertir la cotizacón ${quoteNumber} a orden de venta?`,
      buttons: true,
      buttons: ['Cancelar', 'Aceptar']
    })
    .then((willDelete) => {
      if (willDelete) {
        this.createOrderSale(itemId, rowPosition)
      } 
    });
  }

	createOrderSale(id, quoteNumber){
		var url = `quotes/${id}/update_status`
		Axios({
			method: 'patch',
		  url: url,
		  headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
		  data: { status: 'order_sale' }
		})
		.then(function (response) {
    	if (response['status'] == 204) {
				toastr.options.preventDuplicates = true;
				toastr.options.closeButton = true;
				toastr.success('Operación realizada con exito!', {timeOut: 2000})
    	}
  	});
	}

	selectAll(){
    if(this.selectAllTarget.checked){
    	this.checkQuoteTargets.forEach(element => element.checked = true);
    	this.consolidateButtonTarget.disabled = false
    }else{
    	this.checkQuoteTargets.forEach(element => element.checked = false);
    	this.consolidateButtonTarget.disabled = true
    }
  }

  enableConsolidateButton(){
  	console.log(this.checkQuoteTargets)
  }

  confirmCancelQuote(e){
    console.log("confirmCancelQuote")
    e.preventDefault()
    var quoteNumber = event.currentTarget.getAttribute('data-quoteNumber')
    var quote_id = event.currentTarget.getAttribute('data-id')
    var cancel = event.currentTarget.getAttribute('data-cancel')
    var msg = ''
    if (cancel == '0') {
      msg = 'Deseas activar la cotizacón'
    }else{
      msg = 'Deseas cancelar la cotizacón'
    }
    swal({
      title: "Requiere confirmación!",
      text: `${msg} ${quoteNumber}?`,
      buttons: true,
      buttons: ['Cancelar', 'Aceptar']
    })
    .then((willDelete) => {
      if (willDelete) {
        this.cancelQuote(quote_id, cancel)
      } 
    });
  }

  cancelQuote(id, cancel){
    var url = `/crm/quotes/${id}/cancel`
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
