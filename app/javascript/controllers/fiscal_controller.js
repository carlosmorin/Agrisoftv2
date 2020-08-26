import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {
  static targets = ["nameInput", "fiscalNameInput", "setAsFiscalAddress", 
  	"countrySelect", "stateSelect", "countrySelectFiscal", "stateSelectFiscal", 
  	"cpInputFiscal", "cpInput"]

  connect() {
  	console.log("Init")
  }

  setFiscalName(){
  	let name = this.nameInputTarget.value
  	this.fiscalNameInputTarget.value = name
  }

  setAsFiscalAddress(){
  	let country = this.countrySelectTarget.value
  	let state = this.stateSelectTarget.value
  	let cp = this.cpInputTarget.value
  	
    let country_select_id = this.countrySelectFiscalTarget.id

    if (this.setAsFiscalAddressTarget.checked) {
      this.countrySelectFiscalTarget.value = country
    }else{
  		console.log("Not checked")
  	}
  }
}
