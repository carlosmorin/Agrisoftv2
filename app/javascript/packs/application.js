// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("admin-lte")
require('jquery')
import "bootstrap"
import "../stylesheets/application"
import 'cocoon-js'

document.addEventListener("turbolinks:load", () => {
	$('#shipments').on('cocoon:after-insert', function(e, insertedItem) {
  	alert("aasdoiasdnioasdn");
  });
	$('[data-toggle="tooltip"]').tooltip()
	$('[data-toggle="popover"]').popover()
	$(document).on("cocoon:before-insert", function() {
		alert("lago pasa :o!")
	})
})

import "controllers"

