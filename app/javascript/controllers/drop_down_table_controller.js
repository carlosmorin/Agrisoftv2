import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
  }

  toggleDropDown(e){
  	let id = e.currentTarget.getAttribute('data-id')
  	$(`tr.dropdown_${id}`).toggleClass('d-none')
  }
}
