import EasyMDE from "easymde";
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.loadMarkdownEditor();
  }

  loadMarkdownEditor() {
    new EasyMDE({
      element: this.element,
      sideBySideFullscreen: false,
      spellChecker: false,
      toolbar: ["bold", "italic", "strikethrough", "heading", "|", "quote", "unordered-list", "ordered-list", "|",  "table", "|", "image", "link"]
    });
  }
}
