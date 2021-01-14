import PerfectScrollbar from "perfect-scrollbar/dist/perfect-scrollbar";

const sidebarMenuContainerClass = "js-left-sidebar";
const fullSidebarClass = "full";
const miniSidebarClass = "mini-sidebar";
const showSidebarClass = "show-sidebar";

class SidebarMenu {

  constructor() {
    const sidebarMenuContainer = $("." + sidebarMenuContainerClass);
    this.url = window.location + "";
    this.path = this.url.replace(window.location.protocol + "//" + window.location.host + "/", "/");
    this.topUl = sidebarMenuContainer.find("ul:first");

    if(this.path !== "/") {
      this.element = this.topUl.find("a").filter((index, node) => {
        return node.pathname !== "" && node.pathname !== "/" && this.path.indexOf(node.pathname) !== -1;
      });
    }

    this.sidebarToggler = $(".sidebartoggler");
    this.mobileSidebarToggler = $(".js-mobile-sidebar-toggler");
    this.mainWrapper = $(".js-main-wrapper");
    const scrollbarDivClasses = sidebarMenuContainer.find("div").first().attr("class")
    this.scrollbarDivJsClass = scrollbarDivClasses.substr(scrollbarDivClasses.indexOf("js-"))
    this.scrollbar = new PerfectScrollbar("." + this.scrollbarDivJsClass);

    if(this.path !== "/" && this.element != null && this.element.length > 0) {
      this._setClassesInitialElement();
      this._autoScrollToActiveNav();
    }
    this._setEventListeners();
    this._setSidebarType();
  }

  _setClassesInitialElement() {
    this.element.parentsUntil("nav:first").each((index, node) => {
      if ($(node).is("li") && $(node).children("a").length !== 0) {
        $(node).children("a").addClass("active");
        $(node).parent("ul#" + this.topUl.attr("id")).length === 0
          ? $(node).addClass("active")
          : $(node).addClass("selected");
      } else if (!$(node).is("ul") && $(node).children("a").length === 0) {
        $(node).addClass("selected");
      } else if ($(node).is("ul")) {
        $(node).addClass('in');
      }
    });

    this.element.addClass("active");
  }

  _setEventListeners() {
    this.topUl.find("a").on("click", (e) => {
      if (!$(e.currentTarget).hasClass("active")) {
        // hide any open menus and remove all other classes
        $("ul", $(e.currentTarget).parents("ul:first")).removeClass("in");
        $("a", $(e.currentTarget).parents("ul:first")).removeClass("active");

        // open our new menu and add the open class
        $(e.currentTarget).next("ul").addClass("in");
        $(e.currentTarget).addClass("active");
      } else if ($(e.currentTarget).hasClass("active")) {
        $(e.currentTarget).removeClass("active");
        $(e.currentTarget).parents("ul:first").removeClass("active");
        $(e.currentTarget).next("ul").removeClass("in");
      }

      this.scrollbar.update();
    })

    // sidebar toggler
    this.sidebarToggler.on("click", (e) => {
      this.mainWrapper.toggleClass(miniSidebarClass);
      if (this.mainWrapper.hasClass(miniSidebarClass)) {
        this.sidebarToggler.prop("checked", !0);
        this.mainWrapper.attr("data-sidebartype", miniSidebarClass);
      }
      else {
        this.sidebarToggler.prop("checked", !1);
        this.mainWrapper.attr("data-sidebartype", fullSidebarClass);
      }
    });
    
    // mobile sidebar toggler
    this.mobileSidebarToggler.on("click", (e) => {
      this.mainWrapper.toggleClass(showSidebarClass);
      $(".js-mobile-sidebar-toggler i").toggleClass("ti-menu");
    });

    $(window).on("resize", (e) => {
      this._setSidebarType();
    });
  }

  _setSidebarType() {
    const width = (window.innerWidth > 0) ? window.innerWidth : window.screen.width;

    if (width < 1170) {
      this.mainWrapper.attr("data-sidebartype", miniSidebarClass);
      this.mainWrapper.addClass(miniSidebarClass);
    }
    else {
      this.mainWrapper.attr("data-sidebartype", fullSidebarClass);
      this.mainWrapper.removeClass(miniSidebarClass);
    }
  };

  _autoScrollToActiveNav() {
    if ($(window).width() > 768 || window.Touch) {
      $("." + this.scrollbarDivJsClass).animate({
        scrollTop: this.element.offset().top - 250
      }, 500);
    }
  }
}

export default SidebarMenu;