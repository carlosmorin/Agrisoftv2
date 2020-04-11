import { Controller } from "stimulus"
const axios = require('axios');

export default class extends Controller {
	initialize(){
		console.log("conetected")	
	}

	filter_by_country(){
		axios({
  		method: 'GET',
			dataType: "JSON",
		  url: '/addresses/addresses/states?country_id=1'
		})
		.then(function (response) {
			console.log(response)
		});
	}
}
