import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {
  initialize() {
		new SlimSelect({select: '#box_carrier_id'})
		new SlimSelect({select: '#box_box_type_id'})
	}	
}
