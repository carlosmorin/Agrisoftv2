import { Controller } from "stimulus"
import SlimSelect from 'slim-select'
const axios = require('axios');
const $ = require('jquery');

export default class extends Controller {
	static targets = [ "carrierId" , "clientId", "productsContainer", "costInput", "coments"]
	
	connect() {
		let container = this.productsContainerTarget
		$("#products").on('cocoon:after-insert', function(e, insertedItem, originalEvent) {
			let select = $(insertedItem).find("select").attr("id")
			new SlimSelect({select: `#${select}`})
		});

		const ids = [...document.getElementsByTagName('select')].map(el => el.id);
		for (var i=0, max=ids.length; i < max; i++) {
			new SlimSelect({select: `#${ids[i]}`})
		}
	}


	filter_by_carrier(){
		var carrierId = this.carrierIdTarget.value
		this.filter_drivers(carrierId)
		this.filter_units(carrierId)
		this.filter_boxes(carrierId)
	}

	filter_drivers(carrierId){
		var driversSelect = $('select#freight_driver_id')
		driversSelect.empty()
		var url = `/carriers/${carrierId}/get_drivers`
		var options = "<option value=''>SELECCIONA</option>";
		axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name + ' ' + response.data[key].last_name +  "</option>";
			}
			driversSelect.append(options);
		});
	}

	filter_units(carrierId){
		var unitsSelect = $('select#freight_unit_id')
		unitsSelect.empty()
		var url = `/carriers/${carrierId}/get_units`
		var options = "<option value=''>SELECCIONA</option>";
		axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			unitsSelect.append(options);
		});		
	}

	filter_boxes(carrierId){
		var carriersSelect = $('select#freight_box_id')
		carriersSelect.empty()
		var url = `/carriers/${carrierId}/get_boxes`
		var options = "<option value=''>SELECCIONA</option>";
		axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			carriersSelect.append(options);
		});		
	}

	getDeliveryAddress(){
		// da = DeliveryAddress
		var daSelect = $('select#freight_shipments_attributes_0_delivery_address_id')
		daSelect.empty()
		var url = `/clients/${this.clientIdTarget.value}/get_delivery_address`
		var options = "<option>SELECCIONA</option>";
		axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name + "</option>";
			}
			daSelect.append(options);
		});		

	}

	validateCost(){
		console.log(this.costInputTarget.value)
		if (this.costInputTarget.value >= 0){
			$(".radio_buttons").removeAttr("disabled")
		}
	}

	addPayComments(){

		var company = document.getElementById("freight_pay_client_1")
		var client = document.getElementById("freight_pay_client_2")
		const comments =  this.commentsTarget
		if(company.checked){
			var msg = "ESTE FLETE NO GENERA GASTOS POR CONCEPTO DE ENVIÓ AL CLIENTE."
			$("textarea").val(msg)
		}else if(client.checked){
			var msg = "ESTE FLETE SERÁ PAGADO EN DESTINO POR EL "
			msg += `CLIENTE ANTES MENCIONADO, POR LA CANTIDAD DE: $ ${parseFloat(this.costInputTarget.value).toFixed(2)} MXN.`
			$("textarea").val(msg)
		}
	}
}
