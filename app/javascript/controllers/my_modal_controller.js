import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

// Connects to data-controller="my-modal"
export default class extends Controller {
  static targets = ['modalNewEdit']
  connect() {
    this.modal = new bootstrap.Modal(this.modalNewEditTarget)
  }

  open() {
    if (!this.modal.isOpened) {
      this.modal.show()
    }
  }

  close(event) {
    if (event.detail.success) {
      this.modal.hide()
    }
  }

  hideModal() {
    this.modal.hide()
  }
}
