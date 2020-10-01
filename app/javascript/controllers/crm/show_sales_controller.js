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
    'formProductsContainer', 'btnHideFormProducts', 'showProductsForm', 'productsContainer' ]

  connect(){
    console.log("connect")
    $("form#new_shipments_expense").validate();
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
      if (response['status'] == 200) {
        toastr.success('Operación realizada con exito!', {timeOut: 1000})
        $("#shipments_expenses_view").html(response.data)
        this.submitButtonTarget.removeAttribute('disabled')
      }
    });
  }

  saveProducts(e){
    e.preventDefault()
    const url = `/crm/sales/${this.saleIdTarget.value}/products`
    var data = $(e.currentTarget).serialize()

    console.log("url", url)
    console.log("data", data)
    return false
    Axios({
      method: 'PATCH',
      url: url,
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
      data: data
    })
    .then(function (response) {
      if (response['status'] == 200) {
        toastr.success('Operación realizada con exito!', {timeOut: 1000})
        $("#shipments_expenses_view").html(response.data)
        this.submitButtonTarget.removeAttribute('disabled')
      }
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
    this.showProductsFormTarget.classList.add('d-none')
    this.productsContainerTarget.classList.add('d-none')
  }

  hideFormProducts(){
    this.addProductButtonTarget.classList.add('d-none')
    this.submitProductsButtonTarget.classList.add('d-none')
    this.formProductsContainerTarget.classList.add('d-none')
    this.btnHideFormProductsTarget.classList.add('d-none')
    this.showProductsFormTarget.classList.remove('d-none')
    this.productsContainerTarget.classList.remove('d-none')
  }


}