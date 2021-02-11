import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static values = { src: String }

  connect() {
    this.timeout = setTimeout(() => {
      this.element.setAttribute('src', this.srcValue)
    }, 5000)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}