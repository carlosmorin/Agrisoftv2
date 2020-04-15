import { Controller } from "stimulus"
import SlimSelect from 'slim-select'


export default class extends Controller {
  initialize() {
		new SlimSelect({select: '#shipment_carrier_id'})
  }
}
