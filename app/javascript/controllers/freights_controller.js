import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {
	static targets = [ "subtotal", "outputTax", "total", "outputSubtotal", "totalTaxesOutput"]

	initialize() {
		let openController = this;

		$("#freights_taxes").on('cocoon:after-insert', function(e, insertedItem, originalEvent) {
			let select = $(insertedItem).find("select").attr("id")
			new SlimSelect({select: `#${select}`})
		});

		$("#freights_taxes").on('cocoon:after-remove', function(e, item, originalEvent) {
			$(item).find("input.tax_value").removeClass('tax_value')
			openController.calculateTaxes()
		});
		const ids = [...document.getElementsByTagName('select')].map(el => el.id);
		for (var i=0, max=ids.length; i < max; i++) {	
			new SlimSelect({select: `#${ids[i]}`})
		}
	}

	calculateTaxes(){
		let totalTaxes = 0;
		let subtotal = this.subtotalTarget.value == '' ? 0 : parseFloat(this.subtotalTarget.value);
		[...document.getElementsByClassName('tax_value')].map(el => totalTaxes += el.value == '' ? 0 : parseFloat(el.value));
		let total = parseFloat(((subtotal / 100) * totalTaxes))
		this.totalTaxesOutputTarget.textContent = `${totalTaxes} %`		
		this.outputTaxTarget.textContent = `$ ${total == '' ? 0 : total.toFixed(2)}`
		console.log((parseFloat(subtotal) + parseFloat(total)).toFixed(2))
		this.totalTarget.textContent = `$ ${(parseFloat(subtotal) + parseFloat(total)).toFixed(2)}`
	}

	updateSubtotal(){
		let subtotal =  this.subtotalTarget.value
		this.outputSubtotalTarget.textContent = `$ ${parseFloat(subtotal).toFixed(2)}`
		this.calculateTaxes()
	}

}
