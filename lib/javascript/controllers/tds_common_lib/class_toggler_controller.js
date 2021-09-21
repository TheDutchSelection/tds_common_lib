import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static values = { targetElement: String, targetElementId: String, targetToggleClass: String }

  toggle() {
    let targetElement;
    if (this.targetElementIdValue !== null && this.targetElementIdValue !== '') {
      targetElement = document.getElementById(this.targetElementIdValue);
    } else {
      targetElement = document.querySelector(this.targetElementValue);
    }

    targetElement.classList.toggle(this.targetToggleClassValue);
  }

}
