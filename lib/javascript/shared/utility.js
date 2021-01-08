const queryString = require("query-string");

class Utility {

  getUrl() {
    return window.location.pathname;
  }

  getUrlParam(paramName, url = null) {
    const urlQuery = queryString.parse(url ? url : location.search);

    return urlQuery[paramName];
  }

  setBlockVisibilityByCheckbox(checkbox, block) {
    if(checkbox.prop('checked')) {
      block.show();
    }
    else {
      block.hide();
    }
  }
}

export default Utility