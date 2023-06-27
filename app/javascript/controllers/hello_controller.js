import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("CONNECTED!!");
    this.element.textContent = "Hello World!";
  }
}
