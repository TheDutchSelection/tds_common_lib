import Rails from "@rails/ujs";
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  update() {
    Rails.fire(this.element, "submit");
  }
}
