import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
require("bootstrap/dist/js/bootstrap.bundle.min");

Rails.start()

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("../controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

import "controllers";

document.addEventListener("turbo:load", () => {
  // load things after page load
});
