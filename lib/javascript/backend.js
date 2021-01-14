require("@rails/ujs").start();
require("@rails/activestorage").start();
require("bootstrap/dist/js/bootstrap.bundle.min");

import ServicePanel from "./shared/service_panel";
import SidebarMenu from "./shared/sidebar_menu";

$(() => {
  // delay view of page-wrapper, to avoid effects from menu loading
  $("body, .js-page-wrapper").trigger("resize");
  $(".js-page-wrapper").delay(20).show();

  // sidebar menu
  if($('.js-service-panel').length) {
    new SidebarMenu;
  }

  // service panel if present
  if($('.js-left-sidebar').length) {
    new ServicePanel;
  }

  // hide flash notices after 2 seconds
  setTimeout(() => {
    $(".js-flash-notice").fadeOut("slow");
    $(".js-flash-success").fadeOut("slow");
  }, 2000);
});
