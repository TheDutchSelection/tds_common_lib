require("select2/dist/js/select2");
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    closeOnSelect: Boolean
  }

  connect() {
    this.initializeSelectPicker();
  }

  initializeSelectPicker() {
    $(this.element).select2({
      closeOnSelect: this.closeOnSelectValue,
      theme: "bootstrap-5"
    });
  }
}