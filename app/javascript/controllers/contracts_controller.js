import { Controller } from "stimulus"

export default class extends Controller {
	static targets = ["productsContainer", "undefinedCheckbox", "dateRange", 
		"allProducts", 'productsContainer', 'dateRangeContainer']

	toggleProductContainer(){
		if(this.allProductsTarget.checked){
			this.productsContainerTarget.classList.add("disabled-container");
		} else {
			console.log("allProductsTarget NOT checked")
			this.productsContainerTarget.classList.remove("disabled-container");
		}
	}

	hideDatesContainer(){
		if(this.undefinedCheckboxTarget.checked){
			console.log("checked")
			this.dateRangeContainerTarget.classList.add('d-none')
			this.dateRangeTarget.disabled = true
			this.dateRangeTarget.value = null
		}else{
			this.dateRangeContainerTarget.classList.remove('d-none')
			this.dateRangeTarget.disabled = false
		}
	}

	toggleProductsContainer(e){
		console.log("toggleProductsContainer")
		if(e.currentTarget.checked){
			this.productsContainerTarget.classList.add("d-none")
		}else{
			this.productsContainerTarget.classList.remove("d-none")
		}
	}

	disableCurrencySelect(e){
		if (e.currentTarget.checked) {
			$(e.currentTarget).parent().parent().parent().next().find('select').attr('disabled', 'true')
		}else{
			$(e.currentTarget).parent().parent().parent().next().find('select').removeAttr('disabled')
		}
	}

}
