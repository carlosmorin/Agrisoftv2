import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {
  initialize() {
		new SlimSelect({select: '#unit_unit_brand_id'})
  }
}
