import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static values = { displayAttribute: String, sourceRoutePart: String, targetElementId: String, targetRoutePart: String }

  handleSelectChange() {
    this.populateSelect(this.element.value)
  }

  populateSelect(sourceId, targetId = null) {
    const targetSelectBox = document.getElementById(this.targetElementIdValue)
    targetSelectBox.innerHTML = ""
    if (sourceId == null || sourceId === "") {
      const option = document.createElement("option")
      option.value = ""
      option.innerHTML = ""
      targetSelectBox.disabled = true
      targetSelectBox.appendChild(option)
    } else {
      fetch(`/${this.sourceRoutePartValue}/${sourceId}/${this.targetRoutePartValue}`, {
        credentials: "same-origin"
      })
        .then(response => response.json())
        .then(data => {
          targetSelectBox.disabled = false
          data.forEach(item => {
            const option = document.createElement("option")
            option.value = item.id
            option.innerHTML = item[this.displayAttributeValue]
            option.selected = parseInt(targetId) === item.id
            targetSelectBox.appendChild(option)
          });
        });
    }
  }
}
