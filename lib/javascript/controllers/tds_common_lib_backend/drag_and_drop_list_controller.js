import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "dragDropList" ]

  dragDrop(e) {
    const data = e.dataTransfer.getData("application/drag-key");
    const dropTarget = e.target.closest('[data-list-order]');
    const draggedItem = this.dragDropListTarget.querySelector(`[data-list-order='${data}']`);
    const positionComparison = dropTarget.compareDocumentPosition(draggedItem);

    if (positionComparison & 4) {
      dropTarget.insertAdjacentElement('beforebegin', draggedItem);
    } else if ( positionComparison & 2) {
      dropTarget.insertAdjacentElement('afterend', draggedItem);
    }

    this.setListNumbers()
    this.setFormPositionValues()

    e.preventDefault()
  }

  dragEnd() {

  }

  dragEnter(e) {
    e.preventDefault();
  }

  dragOver(e) {
    e.preventDefault();
    return true;
  }

  dragStart(e) {
    e.dataTransfer.setData("application/drag-key", e.target.getAttribute("data-list-order"));
    e.dataTransfer.effectAllowed = "move";
  }

  setListNumbers() {
    for (let i = 0; i < this.dragDropListElements.length; i++) {
      let element = this.dragDropListElements[i];
      let listNumberElementSpan = element.querySelector(`span[data-list-order-nr]`);

      if (listNumberElementSpan !== null) {
        listNumberElementSpan.innerHTML = i + 1;
      }
    }
  }

  setFormPositionValues() {
    for (let i = 0; i < this.dragDropListElements.length; i++) {
      let element = this.dragDropListElements[i];
      let formInput = element.querySelector(`input[data-form-pos]`);

      if (formInput !== null) {
        formInput.value = i;
      }
    }
  }

  get dragDropListElements() {
    return this.dragDropListTarget.children
  }
}