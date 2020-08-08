import { Controller } from "stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
  	console.log("date-picker")
  	flatpickr(".picker-range", {
  		mode: "range",
	    minDate: "today",
	    dateFormat: "Y-m-d"
	  });

  	flatpickr(".date-picker", {
  		mode: "range",
	    minDate: "today",
	    dateFormat: "Y-m-d"
	  });	  
  }
}
