import { Controller } from "stimulus"
const Axios = require('axios');

export default class extends Controller {
  static targets = ['submitButon']

  initialize() {
    console.log("Discounts modal")
  }

  setDiscounts(e){
    e.preventDefault()
    this.submitButonTarget.disabled = true
    let form = document.getElementById('discountsForm')
    let url = form.action
    let data = $(form).serialize();
    let _this = this
    Axios({
      method: 'PATCH',
      url: url,
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
      data: data
    })
    .then(function (response) {
      _this.submitButonTarget.disabled = false
      _this.setDscountsPirces(response.data)
      toastr.success('Operación realizada con exito!', {timeOut: 1000})
    });
  }

  setDscountsPirces(data){
    let quantity = data['quantity'] 
    let total = parseFloat(data['total'])
    let unit_discount =  total / quantity
    console.log('total:', total)
    console.log('quantity:', quantity)
    console.log('unit_discount:', unit_discount)

    // Hacer pruebas de cada uno de los conceptos
    // Calcular el total
    $('div.nested-fields.row').each(function(index, item) {
      let unit_price = $(item).find('input.unit_price').val() - unit_discount 
      let quantity = $(item).find('input.quantity').val()
      $(item).find('input.discount').val(unit_discount.toFixed(2))
      
      let new_import = unit_price * quantity 
      $(item).find('input.import').val(new_import.toFixed(2))
    });
    this.calculateTable()
    $('#discountsModal').modal('hide')
  }

  calculateTable(){
    let total = 0
    $('div.nested-fields.row').each(function(index, item) {
      let unit_price = $(item).find('input.unit_price').val()
      let unit_discount =  $(item).find('input.discount').val()
      let quantity = $(item).find('input.quantity').val()
      let totalRow = quantity * unit_price - unit_discount

      $(item).find('input.import').val(totalRow.toFixed(2))
      total += totalRow
    });
    $("input#bill_subtotal").val(total.toFixed(2))
  }



}
