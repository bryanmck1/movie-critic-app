// app/javascript/controllers/form_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Form controller connected!");
  }
  submit(event) {
    event.preventDefault();

    this.element.submit();
  }
}
