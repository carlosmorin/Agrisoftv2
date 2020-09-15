import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
  	console.log("Order sales")
  }

  confirmCancelOV(){
  	console.log("confirmCancelOV")
  }
}
