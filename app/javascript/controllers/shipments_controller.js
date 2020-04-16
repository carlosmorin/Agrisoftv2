import { Controller } from "stimulus"
import SlimSelect from 'slim-select'
const axios = require('axios');

export default class extends Controller {
	static targets = [ "carrierId" ]
	initialize() {
		new SlimSelect({select: '#shipment_carrier_id'})
		new SlimSelect({select: '#shipment_driver_id'})
		new SlimSelect({select: '#shipment_unit_id'})
		new SlimSelect({select: '#shipment_box_id'})
		new SlimSelect({select: '#shipment_remissions_attributes_0_company_id'})
		new SlimSelect({select: '#shipment_remissions_attributes_0_client_id'})
	}

	filter_by_carrier(){
		var carrierId = this.carrierIdTarget.value
		this.filter_drivers(carrierId)
		this.filter_units(carrierId)
		this.filter_boxes(carrierId)
	}

	filter_drivers(carrierId){
		var driversSelect = $('select#shipment_driver_id')
		driversSelect.empty()
		var url = `/carriers/${carrierId}/get_drivers`
		console.log(url)
		var options = "";
		axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			console.log(options)
			driversSelect.append(options);
		});
	}

	filter_units(carrierId){
		var unitsSelect = $('select#shipment_unit_id')
		unitsSelect.empty()
		var url = `/carriers/${carrierId}/get_units`
		var options = "";
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
		var carriersSelect = $('select#shipment_box_id')
		carriersSelect.empty()
		var url = `/carriers/${carrierId}/get_boxes`
		var options = "";
		axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			console.log(options)
			carriersSelect.append(options);
		});		
	}

}
