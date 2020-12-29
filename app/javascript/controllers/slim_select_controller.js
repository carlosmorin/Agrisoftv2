import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {
  connect() {
    const ids = [...document.getElementsByTagName('select')].map(el => el.id);

    for (var i=0, max=ids.length; i < max; i++) {
      new SlimSelect({select: `#${ids[i]}`})
    }

    if (document.querySelector('.slim-select')){
      new SlimSelect({
        select: document.querySelector('.slim-select')
      })
    }

  }
}
