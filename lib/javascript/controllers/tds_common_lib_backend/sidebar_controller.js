import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    initialEndDate: String,
    initialStartDate: String,
    maxDate: String,
    minDate: String
  }

  connect() {
    this.setActiveMainMenuItem();
  }

  setActiveMainMenuItem() {
    const activeChildSubLink = this.element.querySelector("a.active");
    if (activeChildSubLink !== null) {
      const subMenuParent = activeChildSubLink.closest("nav > ul.nav > li.nav-item");
      if (subMenuParent !== null) {
        subMenuParent.classList.add("active");
        const subMenuDiv = subMenuParent.querySelector("div.collapse")
        const subMenuTitle = subMenuParent.querySelector("[data-bs-toggle='collapse']")
        if (subMenuDiv !== null && subMenuTitle !== null) {
          subMenuDiv.classList.add("show");
          subMenuTitle.setAttribute("aria-expanded", "true")
        }
      }
    }
  }

  closeOtherSubMenus(e) {
    const allActiveSubMenuLinks = this.element.querySelectorAll("[aria-expanded='true']");
    const targetSubMenuLink = e.target.closest("[aria-expanded='true']");
    for (let i = 0; i < allActiveSubMenuLinks.length; ++i) {
      const activeSubMenuLink = allActiveSubMenuLinks[i]
      const activeSubMenuParent = activeSubMenuLink.closest("li.nav-item");
      const subMenuDiv = activeSubMenuParent.querySelector("div.collapse");
      if (activeSubMenuLink !== targetSubMenuLink) {
        activeSubMenuLink.setAttribute("aria-expanded", "false");
        subMenuDiv.classList.remove("show");
      }
    }
  }

  autoOpenCloseIconSubMenu(e) {
    const body = document.querySelector("body");
    if (!('ontouchstart' in document.documentElement)) {
      if (body.classList.contains("sidebar-icon-only")) {
        if (e.type === 'mouseenter') {
          e.target.classList.add("hover-open");
        } else {
          e.target.classList.remove("hover-open");
        }
      }
    }
  }
}
