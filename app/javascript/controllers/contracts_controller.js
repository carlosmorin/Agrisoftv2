import { Controller } from "stimulus"

export default class extends Controller {
	static targets = ["productsContainer", "undefinedCheckbox", "dateRange", "allProducts"]

	toggleProductContainer(){
		if(this.allProductsTarget.checked){
			this.productsContainerTarget.classList.add("disabled-container");
		} else {
			this.productsContainerTarget.classList.remove("disabled-container");
		}
	}

	disableDates(){
		if(this.undefinedCheckboxTarget.checked){
			this.dateRangeTarget.disabled = true
			this.dateRangeTarget.value = null
		}else{
			this.dateRangeTarget.disabled = false
		}
	}
}
