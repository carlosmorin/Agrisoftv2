import { Controller } from "stimulus"
import SlimSelect from 'slim-select'
const Axios = require('axios');
const numeral = require('numeral');

export default class extends Controller {
  static targets = [ "ivaInput", "clientSelect", "contactsSelect"
  	,"quantityInput", "priceInput", "totalRow", "checkIncludeDelivery", 
    "deliverySelectContainer", "netOutput", "inputDiscount", "subTotalOutput",
    "totalOutput", "currencySelect", "exchangeRateInput", "exchangeRateContainer"]

  connect() {
    this.calculeNeto()
    var _this = this

    $("#products")
      .on('cocoon:after-insert', function(e, insertedItem, originalEvent) {
        let selects = $(insertedItem).find("select")
        for (var i = 0, max=selects.length; i < max; i++) {
          new SlimSelect({select: `#${$(selects[i]).attr("id")}`})
        }
      })
      .on("cocoon:after-remove", function () {
        _this.calculeNeto()
      });

    const ids = [...document.getElementsByTagName('select')].map(el => el.id);
    for (var i=0, max=ids.length; i < max; i++) {
      new SlimSelect({select: `#${ids[i]}`})
    }
  }


  toggleDeliverySelect(){
  	var el = this.deliverySelectContainerTarget
		if(this.checkIncludeDeliveryTarget.checked){
			el.classList.toggle("d-none")
  	}else{
			el.classList.toggle("d-none")
  	}
  }

  loadContacts(){

  	var client_id = this.clientSelectTarget.value
		var url = `/crm/clients/${client_id}/get_contacts`

		var options = "";
		var options = "<option value=''>SELECCIONA</option>";

  	Axios({
  		method: 'GET',
			dataType: "JSON",
		  url: url
		})
		.then(function (response) {
			var contacts_select = $("select.contacts-select");
			contacts_select.empty()
			if (response.data.length === 0){ return false }

			for (var key in response.data){
				var full_name = `${response.data[key].name} ${response.data[key].last_name}`
				options += "<option value='"+ response.data[key].id +"'>" + full_name +  "</option>";
			}
			contacts_select.append(options);
		});
  }

  loadDeliveryAddresses(){
		var client_id = this.clientSelectTarget.value
		var url = `/crm/clients/${client_id}/get_delivery_address`

		var options = "";
		var options = "<option value=''>SELECCIONA</option>";

		Axios({
  		method: 'GET',
			dataType: "JSON",
		  url: url
		})
		.then(function (response) {
			var addresses_select = $("select.addresses-select");
			addresses_select.empty()
			if (response.data.length === 0){ return false }
			for (var key in response.data){
				options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
			}
			addresses_select.append(options);
		});
  }


  calculeNeto(){
    var selectsQuantity = this.quantityInputTargets
    var inputsUnitPrice = this.priceInputTargets
    var outpuTotal = this.totalRowTargets
    if( selectsQuantity.length === 0 ) {
      this.setNeto(0)
      return false
    }

    var net = 0
    for (var i=0, max=selectsQuantity.length; i < max; i++) {
      var quantity = selectsQuantity[i].value
      var unit_price = inputsUnitPrice[i].value

      var total = unit_price * quantity
      net += total
      this.setNeto(net)
      var number = numeral(total);
      outpuTotal[i].textContent = `$ ${number.format()}`
    }
    this.applyDiscount()
    this.calculeTotal()
  }

  showExchangeRate(){
    var currency = this.currencySelectTarget.value

    if(currency == "usd"){
      this.exchangeRateContainerTarget.classList.toggle("d-none", "")
    }else{
      this.exchangeRateContainerTarget.classList.add("d-none")
    }
  }

  applyDiscount(){
    var subTotal = this.data.get("netoValue")
    var discount = this.inputDiscountTarget.value
    var totalDiscount = ((subTotal / 100) * discount)

    subTotal = subTotal - totalDiscount
    this.data.set("subTotal", subTotal)
    this.data.set("discount", discount)
    var number = numeral(subTotal)
    this.subTotalOutputTarget.textContent = `$ ${number.format()}`
    this.calculeTotal()
  }

  setNeto(net){
    var number = numeral(net);
    this.netOutputTarget.textContent = `$ ${number.format()}`
    this.data.set("netoValue", net)
  }

  changeIvaValue(){
    var iva = this.ivaInputTarget.value
    this.data.set("iva", iva)
    this.calculeTotal()
  }

  calculeTotal(){
    var iva = this.data.get("iva")
    var subTotal = this.data.get("subTotal")
    var total_iva = ((subTotal / 100) * iva)
    var total = (subTotal + total_iva)
    this.data.set("total", total)
    
    var number = numeral(total);
    this.totalOutputTarget.textContent = `$ ${total}`
  }
    
}
