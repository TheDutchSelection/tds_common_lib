import Rails from "@rails/ujs";
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  onPostError(event) {
    let j;
    for (j = 0; j < this.element.elements.length; ++j) {
      const inputField = this.element.elements[j];

      inputField.readOnly = false;
      inputField.classList.add("is-invalid");
    }
  }

  onPostSuccess(event) {
    let j;
    for (j = 0; j < this.element.elements.length; ++j) {
      const inputField = this.element.elements[j];

      inputField.readOnly = false;
      inputField.classList.remove("is-invalid");
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
