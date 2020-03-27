import { Controller } from "stimulus"
const axios = require('axios').default;

export default class extends Controller {
	static targets = ['submit']
	
	submit(event) {
    event.preventDefault();

		let $form = $(this.element)
  	let url = $form.attr('action')
  	let data = $form.serialize()

  	axios.post(url, data)
	  .then(function (response) {
	    console.log(response);
	  })
	  .catch(function (error) {
	    console.log(error);
	  });
	}
}
