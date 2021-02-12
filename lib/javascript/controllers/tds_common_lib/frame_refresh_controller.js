import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static values = {src: String}

  connect() {
    setInterval(() => {
      this.element.setAttribute('src', this.srcValue)
    }, 5000)
  }
}
