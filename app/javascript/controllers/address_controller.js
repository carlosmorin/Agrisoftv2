import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

const axios = require('axios');

export default class extends Controller {
  static targets = [ "countryId", "stateId", "municipalityId"]

	initialize(){
		const ids = [...document.getElementsByTagName('select')].map(el => el.id);
		for (var i=0, max=ids.length; i < max; i++) {
			new SlimSelect({select: `#${ids[i]}`})
		}
	}

	filter_by_country(){
		var states_select = $('select[name*=state]')
		states_select.empty()
		var country_id = this.countryIdTarget.value
		var url = "/addresses/addresses/states?country_id=" + country_id;
		var options = "";
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

	filter_by_state(){
		var municipality_select = $('select[name*=municipality_id]')
		municipality_select.empty()
		var state_id = this.stateIdTarget.value
		var url = "/addresses/addresses/municipalities?state_id=" + state_id;
		var options = "";
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
