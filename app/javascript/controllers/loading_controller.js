import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["spinner"]

  connect() {
    // Слушаем Turbo события
    document.addEventListener("turbo:before-fetch-request", () => this.show())
    document.addEventListener("turbo:before-fetch-response", () => this.hide())
  }

  show() {
    this.spinnerTarget.classList.remove("d-none")
  }

  hide() {
    this.spinnerTarget.classList.add("d-none")
  }
}