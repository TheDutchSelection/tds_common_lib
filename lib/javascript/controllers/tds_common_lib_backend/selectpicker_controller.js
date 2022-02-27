require("bootstrap-select");
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    liveSearch: Boolean,
    liveSearchNormalize: Boolean,
    liveSearchPlaceholder: String,
    noneSelectedText: String,
    selectedTextFormat: String
  }

  connect() {
    this.initializeSelectPicker()
  }

  initializeSelectPicker() {
    $.fn.selectpicker.Constructor.BootstrapVersion = '4';

    $(this.element).selectpicker(
      {
        liveSearch: this.liveSearchValue,
        liveSearchNormalize: this.liveSearchNormalizeValue,
        liveSearchPlaceholder: this.liveSearchPlaceholderValue,
        noneSelectedText: this.noneSelectedTextValue,
        selectedTextFormat: this.selectedTextFormatValue,
        styleBase: "form-control"
      }
    );
  }
}