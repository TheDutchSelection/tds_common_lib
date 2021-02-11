import ApplicationController from "./application_controller";

export default class extends ApplicationController {
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
