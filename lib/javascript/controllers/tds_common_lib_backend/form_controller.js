import Rails from "@rails/ujs";
import ApplicationController from "./application_controller";

export default class extends ApplicationController {

  update() {
    Rails.fire(this.element, "submit");
  }
}
