import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { text: String }

  copy() {
    navigator.clipboard.writeText(this.textValue).then(() => {
      this.showSuccess()
    }).catch((err) => {
      console.error("Copy error: ", err)
      alert("Failed to copy to clipboard")
    })
  }

  showSuccess() {
    const originalHTML = this.element.innerHTML
    this.element.innerHTML = '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>'
    this.element.classList.add("bg-green-600")
    this.element.classList.remove("bg-indigo-600", "hover:bg-indigo-700")

    setTimeout(() => {
      this.element.innerHTML = originalHTML
      this.element.classList.remove("bg-green-600")
      this.element.classList.add("bg-indigo-600", "hover:bg-indigo-700")
    }, 2000)
  }
}

