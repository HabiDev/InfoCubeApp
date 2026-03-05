import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.focusWhenVisible()
  }

  focusWhenVisible() {
    const field = this.element.querySelector(
      "input:not([type=hidden]):not([disabled]), textarea:not([disabled]), select:not([disabled])"
    )

    if (!field) return

    if (field.offsetParent === null) {
      setTimeout(() => this.focusWhenVisible(), 50)
      return
    }

    field.focus()
  }
}