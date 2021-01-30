import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    const flashType = this.element.dataset.flashType
    if (flashType === "notice" || flashType === "success") {
      setTimeout( () => {
        this.dismiss()
      }, 2000)
    }
  }

  dismiss() {
    this.element.hidden = true
  }
}
