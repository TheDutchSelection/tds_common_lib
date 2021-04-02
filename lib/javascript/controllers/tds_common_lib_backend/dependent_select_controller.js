import ApplicationController from "./application_controller";

export default class extends ApplicationController {

  handleSelectChange() {
    this.populateSelect(this.element.value)
  }

  populateSelect(sourceId, targetId = null) {
    const targetSelectBox = document.getElementById(this.element.dataset.dependentSelectTargetElementId)
    targetSelectBox.innerHTML = ""
    if (sourceId == null || sourceId === "") {
      const option = document.createElement("option")
      option.value = ""
      option.innerHTML = ""
      targetSelectBox.disabled = true
      targetSelectBox.appendChild(option)
    } else {
      fetch(`/${this.element.dataset.dependentSelectSourceRoutePart}/${sourceId}/${this.element.dataset.dependentSelectTargetRoutePart}`, {
        credentials: "same-origin"
      })
        .then(response => response.json())
        .then(data => {
          targetSelectBox.disabled = false
          data.forEach(item => {
            const option = document.createElement("option")
            option.value = item.id
            option.innerHTML = item[this.element.dataset.dependentSelectDisplayAttribute]
            option.selected = parseInt(targetId) === item.id
            targetSelectBox.appendChild(option)
          });
        });
    }
  }
}
