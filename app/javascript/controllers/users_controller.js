import { Controller } from "stimulus"

export default class extends Controller {

	openModal() {
		$(".modal-body").append("Cargando ..")
		$(".modal-body").empty()
		$("#modal-window").modal();
	}

}