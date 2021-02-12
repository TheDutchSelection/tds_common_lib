import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  connect() {
    this.resizeAndShow()
  }

  resizeAndShow() {
    $(this.element).trigger("resize");
    $(this.element).delay(20).show();
  }
}
