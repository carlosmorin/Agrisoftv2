import { Controller } from "stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
  	flatpickr(".picker-range", {
  		mode: "range",
	    minDate: "today",
	    dateFormat: "Y-m-d"
	  });
  }
}
