import { Controller } from "stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
  	console.log("date-picker")
  	flatpickr(".picker-range", {
  		mode: "range",
	    dateFormat: "d-m-Y"
	  });

  	flatpickr(".date-picker", {
	    minDate: "today",
	    dateFormat: "d-m-Y"
	  });

    flatpickr(".date-time-picker", {
      minDate: "today",
      enableTime: true,
      dateFormat: "d-m-Y H:i"
    });   
  }
}
