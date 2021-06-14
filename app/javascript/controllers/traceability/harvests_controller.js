import { Controller } from "stimulus";
const $ = require('jquery');
import selectize from "selectize"
const axios = require('axios');

export default class extends Controller {
  static targets = [ "output" ]

  connect(){
    var _this = this
    $("#harvest_logs")
      .on('cocoon:after-insert', function(e, insertedItem, originalEvent) {
      	let area = $(insertedItem).find('select.area')
      	_this.cropSelect = $(insertedItem).find('select.crop')
      	_this.initSelectize(area)
    });

   var listItems = $("#harvest_logs .nested-fields")
    listItems.each(function(index, item) { 
      let area = $(item).find('select.area')
      _this.cropSelect = $(item).find('select.crop')
      _this.initSelectize(area)
    })
  }

  initSelectize(input){
    var _this = this
    $(input).selectize({
      onChange: function(value) {
      	console.log("value", value)
      	_this.getCrop(value)
      }
    });
  }

  getCrop(id){
    var _this = this
    let url = `/traceability/harvests/get_crop/?area_id=${id}`
  	axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			$(_this.cropSelect).val()
			$(_this.cropSelect).val(response.data['id'])
		});
  }
}