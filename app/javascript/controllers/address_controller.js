import { Controller } from "stimulus"

const axios = require('axios');

export default class extends Controller {
  static targets = [ "countrySelect", "stateId", "municipalityId", "countryIds"]

	initialize(){
		console.log("Init addresses")
	}

	filter_by_country(event){
		var current_target = event.currentTarget
		var states_select = $("." + current_target.getAttribute('data-container')).find('select[name*=state]')
		states_select.empty()
		var country_id = current_target.value
		var url = "/addresses/addresses/states?country_id=" + country_id;
		var options = "";
		var options = "<option value=''>SELECCIONA</option>";
		
		axios({
  		method: 'GET',
			dataType: "JSON",
		  url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			states_select.append(options);
		});
	}

	filter_by_state(event){
		var current_target = event.currentTarget
		var municipality_select = $("." + current_target.getAttribute('data-container')).find('select[name*=municipality_id]')
		
		if (municipality_select.length == 0) { return false; }
		
		municipality_select.empty()
		var state_id = this.stateIdTarget.value
		var url = "/addresses/addresses/municipalities?state_id=" + state_id;
		var options = "";
		var options = "<option value=''>SELECCIONA</option>";
		axios({
  		method: 'GET',
			dataType: "JSON",
		  url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			municipality_select.append(options);
		});

	}

	municipalities_by_state(){
		var location_select = $('select[name*=location_id]')
		location_select.empty()
		var location_id = this.municipalityIdTarget.value
		var url = "/addresses/addresses/locations?location_id=" + location_id;
		var options = "";
		var options = "<option value=''>SELECCIONA</option>";
		
		axios({
  		method: 'GET',
			dataType: "JSON",
		  url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			location_select.append(options);
		});

	}

}
