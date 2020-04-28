import { Controller } from "stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {

  initialize() {
    new SlimSelect({select: '#company_country_id'})
    new SlimSelect({select: '#company_state_id'})
    new SlimSelect({select: '#company_municipality_id'})
  }
}
