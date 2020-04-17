import { Controller } from "stimulus"
import SlimSelect from 'slim-select'
const axios = require('axios');

export default class extends Controller {
	static targets = [ "cropId" ]

	initialize() {
		new SlimSelect({select: '#product_id'})
		new SlimSelect({select: '#quality_id'})
		new SlimSelect({select: '#client_brand_id'})
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
		var options = "";
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
		var options = "";
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
		var options = "";
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
		var options = "";
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
