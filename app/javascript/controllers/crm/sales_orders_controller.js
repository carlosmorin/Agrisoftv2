import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "appoinmentContainer" ]

  connect() {
  	console.log(this.appoinmentContainerTarget)
  }

  toggleAppoinmentContainer(e){
  	if (e.currentTarget.checked) {
  		this.appoinmentContainerTarget.classList.remove('d-none')
  	}else{
  		this.appoinmentContainerTarget.classList.add('d-none')
  	}

  }

}
