import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    dataSubSelectName: String,
    displayAttribute: String,
    sourceRouteExtraElementIdFirst: String,
    sourceRouteExtraElementIdSecond: String,
    sourceRoute: String,
    targetAllowEmptyValue: Boolean,
    targetElementId: String,
    targetSubElementId: String,
    targetSubSubElementId: String,
  }

  connect() {
    this.populateSelect();
  }

  handleSelectChange() {
    this.populateSelect(false);
  }

  populateSelect(init = true) {
    const sourceValue = this.element.value;

    if (sourceValue == null || sourceValue === "") {
      // reset sub sub target
      if (this.targetSubElementIdValue) {
        this.clearAndDisableTargetSelect(this.targetSubElementIdValue);
      }

      // reset sub target
      if (this.targetSubSubElementIdValue) {
        this.clearAndDisableTargetSelect(this.targetSubSubElementIdValue);
      }

      // reset target
      this.clearAndDisableTargetSelect(this.targetElementIdValue);
    } else if (!init) {
      const targetSelectBox = document.getElementById(this.targetElementIdValue);

      // reset sub sub target
      if (this.targetSubElementIdValue) {
        this.clearAndDisableTargetSelect(this.targetSubElementIdValue);
      }

      // reset sub target
      if (this.targetSubSubElementIdValue) {
        this.clearAndDisableTargetSelect(this.targetSubSubElementIdValue);
      }

      // reset target
      this.clearAndDisableTargetSelect(this.targetElementIdValue);

      // fill target
      let fetchUrl = this.sourceRouteValue;
      
      fetchUrl = fetchUrl.replace('__this_element_value__', sourceValue);

      if (this.sourceRouteExtraElementIdFirstValue) {
        const extraElement = document.getElementById(this.sourceRouteExtraElementIdFirstValue);
        const extraElementValue = extraElement.value;
        fetchUrl = fetchUrl.replace('__extra_element_value_1__', extraElementValue);
      }

      if (this.sourceRouteExtraElementIdSecondValue) {
        const extraElement = document.getElementById(this.sourceRouteExtraElementIdSecondValue);
        const extraElementValue = extraElement.value;
        fetchUrl = fetchUrl.replace('__extra_element_value_2__', extraElementValue);
      }
      
      fetch(fetchUrl, {
        credentials: "same-origin"
      })
        .then(response => response.json())
        .then(data => {
          targetSelectBox.innerHTML = "";
          targetSelectBox.disabled = false

          if (this.targetAllowEmptyValueValue) {
            const option = document.createElement("option");
            option.value = "";
            targetSelectBox.appendChild(option);
          }

          let dataElements = data;

          if (this.dataSubSelectNameValue) {
            dataElements = data[this.dataSubSelectNameValue];
          }

          dataElements.forEach(item => {
            const option = document.createElement("option")
            option.value = item.id
            option.innerHTML = item[this.displayAttributeValue]
            targetSelectBox.appendChild(option)
          });
        });
    }
  }

  clearAndDisableTargetSelect(targetElementId) {
    const targetSelectBox = document.getElementById(targetElementId);
    targetSelectBox.innerHTML = "";
    const option = document.createElement("option");
    option.value = "";
    option.innerHTML = "";
    targetSelectBox.disabled = true;
    targetSelectBox.appendChild(option);
  }
}
