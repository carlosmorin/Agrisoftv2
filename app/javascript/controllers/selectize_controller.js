import { Controller } from "stimulus"
import selectize from "selectize"

export default class extends Controller {
  connect() {
  	$("select.selectize").selectize()
  }
}
