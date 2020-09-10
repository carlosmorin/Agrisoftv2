import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
  	console.log("createOrderSale")
  }

  confirmSaleOrder(e){
  	e.preventDefault()
  	var order_sale_id = e.currentTarget.getAttribute('data-id')
  	var url = e.currentTarget.getAttribute('data-url')
  	var folio = e.currentTarget.getAttribute('data-folio')
  	swal({
      title: "Requiere confirmación!",
      html: true,
      text: `Deseas convertir la orden de venta ${folio} a un embarque?`,
      buttons: true,
      buttons: ['Cancelar', 'Aceptar']
    })
    .then((willDelete) => {
      if (willDelete) {
				Turbolinks.visit(url)
      } 
    });

  }
}
