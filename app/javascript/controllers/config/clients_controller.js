import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "currency" ]

  connect() {
  }

  choseCurrency(e){
  	let nationality = e.currentTarget.value
  	console.log("nationality", nationality)
  	if (nationality == 'national') {
  		this.currencyTarget.selectedIndex = 1
  	}else if(nationality == 'international'){
  		this.currencyTarget.selectedIndex = 2
  	}
  }

}