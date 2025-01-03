import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="my-modal"
export default class extends Controller {
  static targets = [ 'content', 'loading', 'contentDivisions', 'contentOrders', 'link', 'contentAssortments', 'contentOrderCoolings' ];
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
    this.contentDivisionsTarget.classList.add('d-none');
    // balanceContent.classList.add('d-none');
    console.log(event.detail.url)
  }

  displayContentDivisions() {
    // const balanceContent = document.getElementById("balance_#{cardIdValue}")
    this.loadingTarget.classList.add('d-none');
    this.contentDivisionsTarget.classList.remove('d-none');
    // balanceContent.classList.remove('d-none');
  }

  displayOrdersLoading(event) {
    // const balanceContent = document.getElementById("balance_" + cardIdValue)
    this.loadingTarget.classList.remove('d-none');
    this.contentOrdersTarget.classList.add('d-none');
    // balanceContent.classList.add('d-none');
    console.log(event.detail.url)
  }

  displayAssortmentsLoading(event) {
    // const balanceContent = document.getElementById("balance_" + cardIdValue)
    this.loadingTarget.classList.remove('d-none');
    this.contentAssortmentsTarget.classList.add('d-none');
    // balanceContent.classList.add('d-none');
    console.log(event.detail.url)
  }

  displayOrderCoolingsLoading(event) {
    // const balanceContent = document.getElementById("balance_" + cardIdValue)
    this.loadingTarget.classList.remove('d-none');
    this.contentOrderCoolingsTarget.classList.add('d-none');
    // balanceContent.classList.add('d-none');
    console.log(event.detail.url)
  }

  displayContentOrders() {
    // const balanceContent = document.getElementById("balance_#{cardIdValue}")
    this.loadingTarget.classList.add('d-none');
    this.contentOrdersTarget.classList.remove('d-none');
    // balanceContent.classList.remove('d-none');
  }

  displayContentAssortments() {
    // const balanceContent = document.getElementById("balance_#{cardIdValue}")
    this.loadingTarget.classList.add('d-none');
    this.contentAssortmentsTarget.classList.remove('d-none');
    // balanceContent.classList.remove('d-none');
  }

  displayContentOrderCoolings() {
    // const balanceContent = document.getElementById("balance_#{cardIdValue}")
    this.loadingTarget.classList.add('d-none');
    this.contentOrderCoolingsTarget.classList.remove('d-none');
    // balanceContent.classList.remove('d-none');
  }
  
}
