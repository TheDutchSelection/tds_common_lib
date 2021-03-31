import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = [ "source", "target" ];

  handleSelectChange() {
    this.populateSelect(this.sourceTarget.value);
  }

  populateSelect(sourceId, targetId = null) {
    fetch(`/${this.element.dataset.dependentSelectSourceRoutePart}/${sourceId}/${this.element.dataset.dependentSelectTargetRoutePart}`, {
      credentials: 'same-origin'
    })
      .then(response => response.json())
      .then(data => {
        const selectBox = this.targetTarget;
        selectBox.innerHTML = '';
        data.forEach(item => {
          const opt = document.createElement('option');
          opt.value = item.id;
          opt.innerHTML = item[this.element.dataset.dependentSelectDisplayAttribute];
          opt.selected = parseInt(targetId) === item.id;
          selectBox.appendChild(opt);
        });
      });
  }
}
