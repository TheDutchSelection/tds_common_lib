import PerfectScrollbar from "perfect-scrollbar/dist/perfect-scrollbar";

const servicePanelClass = "js-service-panel";
const mainContentClass = "js-left-sidebar";

class ServicePanel {

  constructor() {
    this.contentContainer = $("." + mainContentClass);
    this.servicePanelContainer = $("." + servicePanelClass);
    this.servicePanelToggle = $("." + servicePanelClass + "-toggle")

    new PerfectScrollbar("." + servicePanelClass + "-body");

    this._setEventListeners();
  }

  _setEventListeners() {
    this.servicePanelToggle.on("click", (e) => {
      this.servicePanelContainer.toggleClass('show-service-panel');
    });

    this.contentContainer.on("click", (e) => {
      this.servicePanelContainer.removeClass('show-service-panel');
    });
  }
}

export default ServicePanel;