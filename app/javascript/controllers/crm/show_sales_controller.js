import { Controller } from "stimulus"
import swal from 'sweetalert';
const Axios = require('axios');
const toastr = require('toastr');
const validate = require('jquery-validation');

export default class extends Controller {
  static targets = [ 'saleId', 'contractId', 'contractExchange', 'expense', 
    'unit', 'amount', 'percentage', 'addExpenseButton', 'formContainer', 
    'submitButton', 'expensesContainer', 'showForm', 'hideForm', 'submitProductsButton',
    'addProductButton', 'formProductsContainer', 'addProductButton', 'submitProductsButton', 
    'formProductsContainer', 'btnHideFormProducts', 'btnCancelProducts', 'showProductsForm', 
    'productsContainer', 'usdContainer', 'mxnContainer' ]

  connect(){
    console.log("connect")
    $("form#new_shipments_expense").validate();
    $("#shipments_product_reports")
      .on('cocoon:after-insert', function(e, insertedItem, originalEvent) {
          console.log("shipments_product_reports")
      })
  }

  linkContract(e){
  	e.preventDefault()
  	var sale_id = this.saleIdTarget.value
  	var contract_id = this.contractIdTarget.value
    var echange = this.contractExchangeTarget.value
		var url = `/crm/sales/${sale_id}/set_contract`

		Axios({
			method: 'patch',
		  url: url,
		  headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
		  data: { sale_id: sale_id, contract_id: contract_id, echange: echange }
		})
		.then(function (response) {
    	if (response['status'] == 204) {
    		$('#acModal').modal('hide')
    		toastr.success('Operación realizada con exito!', {timeOut: 1000})
        setTimeout(function(){ Turbolinks.visit(window.location, { action: 'replace' }) }, 1000);
    	}
  	});
  }

  saveExpenses(e){
    e.preventDefault()
    const url = `/crm/sales/${this.saleIdTarget.value}/expenses`
    var data = $(e.currentTarget).serialize()

    Axios({
      method: 'PATCH',
      url: url,
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
      data: data
    })
    .then(function (response) {
      toastr.success('Operación realizada con exito!', {timeOut: 1000})
      Turbolinks.visit(window.location, { action: 'replace' })
    });
  }

  saveProducts(e){
    e.preventDefault()
    const url = `/crm/sales/${this.saleIdTarget.value}/products`
    var data = $(e.currentTarget).serialize()
    var _this = this
    Axios({
      method: 'PATCH',
      url: url,
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
      data: data
    })
    .then(function (response) {
      console.log("Status:", response['status'])
      if (response['status'] == 200) {
        toastr.success('Operación realizada con exito!', {timeOut: 1000})
        $("#productsContainer").html(response.data)
        Turbolinks.visit(window.location.href)
      }
    });
  }

  saveDocuments(e){
    e.preventDefault()
    console.log("saveDocuments")
    const url = `/crm/sales/${this.saleIdTarget.value}/documents`
    var form = e.currentTarget
    var formData = new FormData(form);
    var _this = this
    Axios({
      method: 'PATCH',
      url: url,
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
      data: formData
    })
    .then(function (response) {
      console.log(response['status'])
      if (response['status'] == 204 || response['status'] == 200) {
        toastr.success('Operación realizada con exito!', {timeOut: 1000})
        $("#docsContainer").html(response.data)
        $('#docsModal').modal('hide')
        form.reset();
      }
    });
  }

  passToCollect(sale_id){
    const url = `/crm/sales/${sale_id}/to_collect`
    var _this = this

    Axios({
      method: 'GET',
      url: url
    })
    .then(function (response) {
      console.log("response", response['status'])
      toastr.success('Operación realizada con exito!', {timeOut: 1000})
      Turbolinks.visit(window.location, { action: 'replace' })
    });
  }

  calculateRow(e){
    var expenses = this.expenseTargets
    var units = this.unitTargets
    var amounts = this.amountTargets 
    var percentage = this.percentageTargets 
  }

  showForm(){
    this.addExpenseButtonTarget.classList.remove('d-none')
    this.submitButtonTarget.classList.remove('d-none')
    this.formContainerTarget.classList.remove('d-none')
    this.hideFormTarget.classList.remove('d-none')
    this.showFormTarget.classList.add('d-none')
    this.expensesContainerTarget.classList.add('d-none')
    console.log("toggleForm")
  }

  hideForm(){
    this.addExpenseButtonTarget.classList.add('d-none')
    this.submitButtonTarget.classList.add('d-none')
    this.formContainerTarget.classList.add('d-none')
    this.expensesContainerTarget.classList.remove('d-none')
    this.hideFormTarget.classList.add('d-none')
    this.showFormTarget.classList.remove('d-none')
  }

  /// Products form
  showFormProducts(){
    console.log("showFormProducts")
    this.addProductButtonTarget.classList.remove('d-none')
    this.submitProductsButtonTarget.classList.remove('d-none')
    this.formProductsContainerTarget.classList.remove('d-none')
    this.btnHideFormProductsTarget.classList.remove('d-none')
    this.btnCancelProductsTarget.classList.remove('d-none')
    this.showProductsFormTarget.classList.add('d-none')
    this.productsContainerTarget.classList.add('d-none')
  }

  hideFormProducts(){
    this.addProductButtonTarget.classList.add('d-none')
    this.submitProductsButtonTarget.classList.add('d-none')
    this.formProductsContainerTarget.classList.add('d-none')
    this.btnHideFormProductsTarget.classList.add('d-none')
    this.btnCancelProductsTarget.classList.add('d-none')
    this.showProductsFormTarget.classList.remove('d-none')
    this.productsContainerTarget.classList.remove('d-none')
  }

  reloadUrl(containerId){
    console.log("reloadUrl", containerId)
    var reload_url = window.location.href.split("#")
    if (reload_url.length > 1) {
      Turbolinks.visit(window.location.href)
    }else{
      Turbolinks.visit(`${window.location.href}#${containerId}`)
    }
  }

  showMxnSumary(e){
    this.mxnContainerTarget.classList.remove('d-none')
    this.usdContainerTarget.classList.add('d-none')
  }

  showUsdSumary(e){
    this.usdContainerTarget.classList.remove('d-none')
    this.mxnContainerTarget.classList.add('d-none')
  }

  confirmPassToCollect(e){
    let sale_id = e.currentTarget.getAttribute('data-saleid')
    let folio = e.currentTarget.getAttribute('data-folio')
    
    swal({
      title: 'Requiere confirmación!',
      text: `Deseas pasar la venta con folio: ${ folio } a cobranza?`,
      buttons: true,
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {
        this.passToCollect(sale_id)
      } else {
        swal("No se pudó llevar a cabo esta acción");
      }
    });
  }

}