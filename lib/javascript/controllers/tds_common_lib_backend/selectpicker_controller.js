require("bootstrap-select");
import ApplicationController from "./application_controller";

export default class extends ApplicationController {
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