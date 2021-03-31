import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = [ "source", "target" ];

  handleSelectChange() {
    this.populateSelect(this.sourceTarget.value);
  }

  populateSelect(sourceId, targetId = null) {
    fetch(`/${this.data.get('sourceRoutePart')}/${sourceId}/${this.data.get('targetRoutePart')}`, {
      credentials: 'same-origin'
    })
      .then(response => response.json())
      .then(data => {
        const selectBox = this.targetTarget;
        selectBox.innerHTML = '';
        data.forEach(item => {
          const opt = document.createElement('option');
          opt.value = item.id;
          opt.innerHTML = item[this.data.get('displayAttribute')];
          opt.selected = parseInt(targetId) === item.id;
          selectBox.appendChild(opt);
        });
      });
  }
}
