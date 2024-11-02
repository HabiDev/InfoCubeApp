import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="my-modal"
export default class extends Controller {
  static targets = [ 'content', 'loading', 'contentDivisions', 'contentOrders', 'link' ];
  static values = { balance: String };

  connect() {
    console.log("Ok. My-Loading")
  }

  displayLoading(event) {
    this.loadingTarget.classList.remove('d-none');
    this.contentTarget.classList.add('d-none');
  }

  displayContent() {
    this.loadingTarget.classList.add('d-none');
    this.contentTarget.classList.remove('d-none');
  }

  displayDivisionsLoading(event) {
    // const balanceContent = document.getElementById("balance_" + cardIdValue)
    this.loadingTarget.classList.remove('d-none');
    this.contentCardsTarget.classList.add('d-none');
    // balanceContent.classList.add('d-none');
    console.log(event.detail.url)
  }

  displayContentDivisions() {
    // const balanceContent = document.getElementById("balance_#{cardIdValue}")
    this.loadingTarget.classList.add('d-none');
    this.contentCardsTarget.classList.remove('d-none');
    // balanceContent.classList.remove('d-none');
  }

  displayOrdersLoading(event) {
    // const balanceContent = document.getElementById("balance_" + cardIdValue)
    this.loadingTarget.classList.remove('d-none');
    this.contentCardsTarget.classList.add('d-none');
    // balanceContent.classList.add('d-none');
    console.log(event.detail.url)
  }

  displayContentOrders() {
    // const balanceContent = document.getElementById("balance_#{cardIdValue}")
    this.loadingTarget.classList.add('d-none');
    this.contentCardsTarget.classList.remove('d-none');
    // balanceContent.classList.remove('d-none');
  }
  
}
