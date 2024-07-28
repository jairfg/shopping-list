import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  check_purchased(event){
    const id = event.target.dataset.id
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch(`/products/${id}/check_purchased`, {
      method: 'PUT',
      mode: 'cors',
      cache: 'no-cache',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ purchased: event.target.checked })
    })
    .then(response => response.text())
    .then(Turbo.renderStreamMessage)
  }
}
