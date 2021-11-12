import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ["dateRangeCheckbox", "saveAsInput"]

  connect() {
    this.setDateRangeCheckBox()
  }

  setDateRangeCheckBox() {
    if (this.hasDateRangeCheckboxTarget) {
      if (this.saveAsInputTarget.value === "") {
        this.dateRangeCheckboxTarget.style.display = "none"
      } else {
        this.dateRangeCheckboxTarget.style.display = "block"
      }
    }
  }
}
