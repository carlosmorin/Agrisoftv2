import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {
  initialize() {
		new SlimSelect({select: '#client_country_id'})
		new SlimSelect({select: '#client_state_id'})
		new SlimSelect({select: '#client_municipality_id'})
  }
}
