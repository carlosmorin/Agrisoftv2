import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {
  initialize() {
  	$("#freights_taxes").on('cocoon:after-insert', function(e, insertedItem, originalEvent) {
			let select = $(insertedItem).find("select").attr("id")
			new SlimSelect({select: `#${select}`})
		});
		const ids = [...document.getElementsByTagName('select')].map(el => el.id);
		for (var i=0, max=ids.length; i < max; i++) {
			new SlimSelect({select: `#${ids[i]}`})
		}
  }
}
