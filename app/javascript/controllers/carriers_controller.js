import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {
  initialize() {
		new SlimSelect({select: '#carrier_country_id'})
		new SlimSelect({select: '#carrier_state_id'})
		new SlimSelect({select: '#carrier_municipality_id'})
  }
}
