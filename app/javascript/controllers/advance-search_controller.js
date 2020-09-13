import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "inputContainer" ]

  connect() {
    console.log("advance container")
  }

  toggleAdvancedInputs(e){
  	if (e.currentTarget.checked) {
  		this.inputContainerTargets.forEach(element => element.classList.remove('d-none'));
  	}else{
  		this.inputContainerTargets.forEach(element => element.classList.add('d-none'));
  	}
  }

}
