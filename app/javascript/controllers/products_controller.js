import { Controller } from "stimulus"
import SlimSelect from 'slim-select'
const axios = require('axios');
const toastr = require('toastr');

export default class extends Controller {
	static targets = [ "cropId" ]

	initialize() {
		const ids = [...document.getElementsByTagName('select')].map(el => el.id);
		for (var i=0, max=ids.length; i < max; i++) {
			new SlimSelect({select: `#${ids[i]}`})
		}
  }

  saveProduct(e){
  	e.preventDefault();
		var form = $("#new_product")
    var url = form.attr('action')
		$.ajax({
      type: "POST",
      url: url,
      data: form.serialize(),
      success: function(data){
        toastr.options.preventDuplicates = true;
				toastr.options.closeButton = true;
				toastr.success('Producto registrado con exito', {timeOut: 2000})
				$('#modal-window').modal('hide')
      },
      error: function(xhr, textStatus, errorThrown) {
        var response = xhr.responseJSON;
				var validations = "<ul class='pl-2 mb-1'>";        
        for(var key in response)
				{
					validations += "<li class='s-12'>" + response[key][0] + "</li>";
				}
				validations += "</ul>";        
				$(".callout-danger").removeClass("d-none").empty().html(validations)
        return false;
      }
    });
  }

  filterColorsByCropId(){
  	var cropId = this.cropIdTarget.value
  	this.filterColors(cropId)
  	this.filterQualities(cropId)
  	this.filterSizes(cropId)
  	this.filterPackages(cropId)
  }

  filterColors(cropId){
		var colorsSelect = $('select#product_color_id')
		colorsSelect.empty()
		var url = `/crops/${cropId}/get_colors`
		var options = "<option value=''>SELECCIONA</option>";
		axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			colorsSelect.append(options);
		});
	}

	filterQualities(cropId){
		var qualitySelect = $('select#product_quality_id')
		qualitySelect.empty()
		var url = `/crops/${cropId}/get_qualities`
		var options = "<option value=''>SELECCIONA</option>";
		axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			qualitySelect.append(options);
		});
	}

	filterSizes(cropId){
		var sizeSelect = $('select#product_size_id')
		sizeSelect.empty()
		var url = `/crops/${cropId}/get_sizes`
		var options = "<option value=''>SELECCIONA</option>";
		axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			sizeSelect.append(options);
		});
	}

	filterPackages(cropId){
		var packagesSelect = $('select#product_package_id')
		packagesSelect.empty()
		var url = `/crops/${cropId}/get_packages`
		var options = "<option value=''>SELECCIONA</option>";
		axios({
			method: 'GET',
			url: url
		})
		.then(function (response) {
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			packagesSelect.append(options);
		});
	}
}
