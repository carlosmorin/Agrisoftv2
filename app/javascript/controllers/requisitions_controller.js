import { Controller } from "stimulus";
import SlimSelect from 'slim-select'
import selectize from "selectize"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
  	var _this = this
    $("#supplies")
      .on('cocoon:after-insert', function(e, insertedItem, originalEvent) {
        var select = insertedItem.find("select.supply")
        _this.initSupplyInput(select)
      })
    this.initSelectzeRows()
  }

  initSelectzeRows(){
		var _this = this
  	$('#supplies > .nested-fields').each(function( index ) {
  		var select = $(this).find("select.supply")
       _this.initSupplyInput(select)
  	})
  }

  initSupplyInput(select){
		select.selectize({
	    valueField: 'id',
	    labelField: 'name',
	    searchField: 'name',
	    create: false,
	    render: {
	      option: function(item, escape) {
	      	console.log(item)
          return '<div class="my-1">' + '<span class="s-16">' + escape(item.name) + '</span>' + '</div>';
	      }
	    },
	    load: function(query, callback) {
	      if (!query.length) return callback();
	      $.ajax({
          url: '/api/services/supplies?query=' + encodeURIComponent(query),
          type: 'GET',
          error: function() {
            callback();
          },
          success: function(res) {
            callback(res.repositories.slice(0, 10));
          }
	      });
	    }
		});
  }
}