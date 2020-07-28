import { Controller } from "stimulus"
const Axios = require('axios');


export default class extends Controller {
  static targets = [ "output" ]

  initialize() {
    const API_URI = 'http://api.openweathermap.org/data/2.5/weather'
    const API_KEY = '3fc82b390a874c7c422510d5488b0722'
    const LOCAL_CITY = 'Parras de la Fuente,MX'

    const url = `${API_URI}?q=${LOCAL_CITY}&appid=${API_KEY}`
    Axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			var temp = response['data']['main']['temp'] - 273.15
			var icon_code = response['data']['weather'][0]['icon']
			var url_icon = `http://openweathermap.org/img/wn/${icon_code}.png`
			var span = `<span class="s-12 bold">${temp.toFixed(1)} °C <img src="${url_icon}" width="25"></span>` 

			$("#output").empty()
			$("#output").append(span)
		});	
  }
}
