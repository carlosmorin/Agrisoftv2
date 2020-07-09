import { Controller } from "stimulus"
import swal from 'sweetalert';
const Axios = require('axios');
const toastr = require('toastr');

export default class extends Controller {
	static targets = ['row']

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
  			var row = this.rowTargets[rowPosition]
  			$(row).fadeOut('fast')
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

}
	