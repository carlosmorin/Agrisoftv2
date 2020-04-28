import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  initialize() {
    console.log("Log")
  }
}
