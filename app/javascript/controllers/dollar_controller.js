import { Controller } from "stimulus"
const Axios = require('axios');

export default class extends Controller {
  initialize() {
    const API_URI = 'https://api.exchangeratesapi.io/latest'
    const BASE_CURRENCY = 'USD'
    const URL = `${API_URI}?base=${BASE_CURRENCY}`
    Axios({
			method: 'GET',
			url: URL
		})
		.then(function (response) {
			var dollar_price = response['data']['rates']['MXN']
			var span = `<span class="s-12">1 USD = ${dollar_price.toFixed(2)} MXN </span>` 

			$("#outputDollar").empty()
			$("#outputDollar").append(span)
		});	
  }
}
