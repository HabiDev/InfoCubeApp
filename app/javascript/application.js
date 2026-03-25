// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

document.addEventListener("submit", function(e) {
  const form = e.target
  const btn = form.querySelector('input[type="submit"], button[type="submit"]')
  if (btn) {
    btn.value = 'Подождите идет загрузка...'
    btn.disabled = true
  }
})
