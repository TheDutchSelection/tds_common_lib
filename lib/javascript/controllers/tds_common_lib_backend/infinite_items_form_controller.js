import Rails from "@rails/ujs";
import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = [ "addField", "removeField" ]

  addItem() {
    this.addFieldTarget.value = '1'
    this.update()
  }

  deleteItem(event) {
    this.removeFieldTarget.value = event.currentTarget.dataset.itemIndex
    this.update()
  }

  update() {
    Rails.fire(this.element, "submit");
  }
}
