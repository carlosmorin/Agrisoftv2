import { Controller } from "stimulus";
import SlimSelect from 'slim-select'
import selectize from "selectize"
import flatpickr from "flatpickr";


export default class extends Controller {
  static targets = [ "output" ]

	connect() {
		var _this = this
    $("#cicles_areas")
      .on('cocoon:after-insert', function(e, insertedItem, originalEvent) {
       	_this.initDatePickers(insertedItem)
      })

    var listItems = $("#cicles_areas .nested-fields")
    listItems.each(function(index, item) { 
      let fromInput = $(item).find('input.from')
      let toInput = $(item).find('input.to')

      _this.initflatpickr(fromInput)
      _this.initflatpickr(toInput)
    })
	}

	initDatePickers(insertedItem){
		let fromInput = $(insertedItem).find('input.from')
		let toInput = $(insertedItem).find('input.to')

    this.initflatpickr(fromInput)
    this.initflatpickr(toInput)
	}

  initflatpickr(input){
    flatpickr(input, {
      enableTime: true,
      dateFormat: "d-m-Y H:i"
    });
  }
}