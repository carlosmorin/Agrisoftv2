import { Controller } from "stimulus"

export default class extends Controller {
  initialize() {
	}

	confirmOrderSale(event){
		event.preventDefault();
		var current_element = event.currentTarget
		console.log(current_element.getAttribute('data-id'))
	}
}
	