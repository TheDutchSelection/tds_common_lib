import ApplicationController from "./application_controller";

export default class extends ApplicationController {

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
