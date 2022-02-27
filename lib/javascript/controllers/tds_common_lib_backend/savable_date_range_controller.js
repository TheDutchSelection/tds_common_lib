import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
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
