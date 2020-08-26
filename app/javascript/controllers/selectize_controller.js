import { Controller } from "stimulus"
import selectize from "selectize"

export default class extends Controller {
  connect() {
    const ids = [...document.getElementsByTagName('select')].map(el => el.id);

    for (var i=0, max=ids.length; i < max; i++) {
  		$(`#${ids[i]}`).selectize()
    }
  	$("select.selectize").selectize()
  }
}
