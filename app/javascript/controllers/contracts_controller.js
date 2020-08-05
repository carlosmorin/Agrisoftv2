import { Controller } from "stimulus"

export default class extends Controller {
	static targets = ["productsContainer"]

	toggleProductContainer(){
		this.productsContainerTarget.classList.toggle("disabled-container");
	}
}
