import Rails from "@rails/ujs";
import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  onPostSuccess(event) {
    let j;
    for (j = 0; j < this.element.elements.length; ++j) {
      const inputField = this.element.elements[j];

      inputField.readOnly = false;
    }
  }

  update() {
    const isReadOnly = this.element.elements[0].readOnly

    if(!isReadOnly) {
      let j;
      for (j = 0; j < this.element.elements.length; ++j) {
        const inputField = this.element.elements[j];

        inputField.readOnly = true;
      }

      Rails.fire(this.element, "submit");
    }
  }

  reset() {
    this.element.reset()
  }
}
