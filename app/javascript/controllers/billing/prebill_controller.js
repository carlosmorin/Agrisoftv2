import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['quantityInput', 'priceInput', 'importInput', 'subTotal', 'total']

  initialize() {
    console.log("Pre bill Controller")
  }

  calculateRow(e){
  	var index = e.currentTarget.getAttribute('data-index')
  	var quantity = this.quantityInputTargets[index].value
  	var price = this.priceInputTargets[index].value
  	this.importInputTargets[index].value = quantity * price
  }

  setDiscounts(e){
    e.preventDefault()
    console.log("Set discount")
  }

  calculateTotal(e){
    let subTotal = this.subTotalTarget.value
    let total = subTotal - e.currentTarget.value
    console.log("Total:", total)
    this.totalTarget.value = total
  }
}
