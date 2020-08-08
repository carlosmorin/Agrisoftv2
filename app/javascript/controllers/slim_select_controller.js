import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {
  initialize() {
    const ids = [...document.getElementsByTagName('select')].map(el => el.id);

    for (var i=0, max=ids.length; i < max; i++) {
      new SlimSelect({select: `#${ids[i]}`})
    }
  }
}
