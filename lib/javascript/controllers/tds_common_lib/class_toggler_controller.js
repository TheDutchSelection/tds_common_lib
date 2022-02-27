import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
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
