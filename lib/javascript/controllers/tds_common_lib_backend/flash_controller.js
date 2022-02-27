import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static values = { flashType: String }

  connect() {
    if (this.flashTypeValue === "notice" || this.flashTypeValue === "success") {
      setTimeout( () => {
        this.dismiss()
      }, 2000)
    }
  }

  dismiss() {
    this.element.hidden = true
  }
}
