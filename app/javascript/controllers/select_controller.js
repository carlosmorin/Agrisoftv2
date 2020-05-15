// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
		const ids = [...document.getElementsByTagName('select')].map(el => el.id);
		for (var i=0, max=ids.length; i < max; i++) {
			new SlimSelect({select: `#${ids[i]}`})
		}
  }
}
