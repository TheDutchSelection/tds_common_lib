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

import SidebarMenu from "./shared/sidebar_menu";

document.addEventListener("turbo:load", () => {
  // delay view of page-wrapper, to avoid effects from menu loading
  $("body, .js-page-wrapper").trigger("resize");
  $(".js-page-wrapper").delay(20).show();

  // sidebar menu
  if($('.js-left-sidebar').length) {
    new SidebarMenu;
  }
});
